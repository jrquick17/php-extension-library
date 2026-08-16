#!/usr/bin/env python3
import os
import hashlib
import json
import re
import struct
from datetime import datetime, timezone

def calculate_sha256(filepath):
    sha256 = hashlib.sha256()
    with open(filepath, 'rb') as f:
        while chunk := f.read(8192):
            sha256.update(chunk)
    return sha256.hexdigest()

def get_binary_arch(filepath):
    try:
        with open(filepath, 'rb') as f:
            header = f.read(64)
        if len(header) < 8:
            return "x86_64"
        
        # Mach-O (macOS) Magic Numbers
        # MH_MAGIC_64 (0xfeedfacf) -> little endian: cf fa ed fe
        # MH_CIGAM_64 (0xcffaedfe) -> big endian: fe ed fa cf
        magic = header[0:4]
        if magic == b'\xcf\xfa\xed\xfe' or magic == b'\xfe\xed\xfa\xcf':
            endian = '<' if magic == b'\xcf\xfa\xed\xfe' else '>'
            cpu_type = struct.unpack(endian + 'I', header[4:8])[0]
            # CPU_TYPE_X86_64 = 0x01000007, CPU_TYPE_ARM64 = 0x0100000c
            if cpu_type == 0x01000007:
                return "x86_64"
            elif cpu_type == 0x0100000c:
                return "arm64"
            return f"macho_cpu_{cpu_type}"
        
        # ELF Magic Number (\x7fELF)
        if header[0:4] == b'\x7fELF':
            # e_ident[5]: 1 for LSB, 2 for MSB
            endian = '<' if header[5] == 1 else '>'
            # e_machine starts at offset 18 (2 bytes)
            e_machine = struct.unpack(endian + 'H', header[18:20])[0]
            # EM_X86_64 = 62, EM_AARCH64 = 183
            if e_machine == 62:
                return "x86_64"
            elif e_machine == 183:
                return "arm64"
            return f"elf_machine_{e_machine}"
            
        return "x86_64"
    except Exception:
        return "x86_64"

def load_checksums(filepath):
    checksums = {}
    if not os.path.exists(filepath):
        return checksums
    
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = re.split(r'\s+', line, maxsplit=1)
            if len(parts) == 2:
                sha, rel_path = parts
                # Normalize path separators
                rel_path = rel_path.replace('\\', '/')
                checksums[rel_path] = sha
    return checksums

def main():
    repo_root = os.path.abspath(os.path.dirname(__file__))
    checksums_file = os.path.join(repo_root, 'checksums.txt')
    manifest_file = os.path.join(repo_root, 'manifest.json')
    
    expected_checksums = load_checksums(checksums_file)
    
    manifest = {
        "generated": datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ'),
        "extensions": {}
    }
    
    # List all entries in repo root
    entries = sorted(os.listdir(repo_root))
    
    for entry in entries:
        # Match only directories starting with php followed by a digit
        # e.g., php5.0.0, php7.4.0, php8.3.9
        if not re.match(r'^php\d', entry):
            continue
        
        dir_path = os.path.join(repo_root, entry)
        if not os.path.isdir(dir_path):
            continue
            
        # Scan for .so files
        so_files = sorted(os.listdir(dir_path))
        ext_dict = {}
        for so_file in so_files:
            if not so_file.endswith('.so'):
                continue
                
            file_path = os.path.join(dir_path, so_file)
            rel_path = f"{entry}/{so_file}"
            
            # Compute sha256
            sha256 = calculate_sha256(file_path)
            
            # Verify against checksums.txt if it exists
            if rel_path in expected_checksums:
                expected_sha = expected_checksums[rel_path]
                if sha256 != expected_sha:
                    print(f"WARNING: SHA256 mismatch for {rel_path}!")
                    print(f"  Expected (checksums.txt): {expected_sha}")
                    print(f"  Calculated:              {sha256}")
            else:
                print(f"WARNING: {rel_path} not found in checksums.txt")
                
            arch = get_binary_arch(file_path)
            ext_name = so_file[:-3] # remove '.so'
            
            ext_dict[ext_name] = {
                "file": so_file,
                "sha256": sha256,
                "arch": arch
            }
            
        if ext_dict:
            # Sort extension keys inside the directory dictionary (e.g. pcntl, redis, curl)
            sorted_ext_dict = {k: ext_dict[k] for k in sorted(ext_dict.keys())}
            manifest["extensions"][entry] = sorted_ext_dict
            
    with open(manifest_file, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2)
        f.write('\n')
        
    print(f"Successfully generated {manifest_file}")

if __name__ == '__main__':
    main()
