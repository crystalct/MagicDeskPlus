#!/usr/bin/env python3
import sys
import os
import argparse

def crt_to_bin(crt_path, bin_path, convert_to_prg=False):
    if not os.path.exists(crt_path):
        print(f"Error: Input file {crt_path} does not exist.")
        return False

    with open(crt_path, 'rb') as f:
        crt_data = f.read()

    if len(crt_data) < 64:
        print("Error: Invalid CRT file (too small).")
        return False

    # Extract info from CRT header (64 bytes)
    magic = crt_data[0:16]
    machine = "unknown"
    if magic.startswith(b"C64 CARTRIDGE"):
        machine = "C64"
    elif magic.startswith(b"C128 CARTRIDGE"):
        machine = "C128"
    elif magic.startswith(b"CBM2 CARTRIDGE"):
        machine = "CBM2"
    elif magic.startswith(b"VIC20 CARTRIDGE"):
        machine = "VIC20"
    elif magic.startswith(b"PLUS4 CARTRIDGE"):
        machine = "PLUS4"

    # CRT Type is a 16-bit big-endian integer at offset 0x16 (22)
    crt_type = (crt_data[0x16] << 8) | crt_data[0x17]
    if crt_data[0x17] & 0x80:
        crt_type -= 0x10000

    # Parse CHIP packets
    chips = []
    offset = 64
    while offset < len(crt_data):
        if offset + 16 > len(crt_data):
            break
        chip_header = crt_data[offset:offset+16]
        if chip_header[0:4] != b"CHIP":
            break

        # Package length (4 bytes at offset 4, big-endian)
        package_len = (chip_header[4] << 24) | (chip_header[5] << 16) | (chip_header[6] << 8) | chip_header[7]
        # Chip type (2 bytes at offset 8)
        chip_type = (chip_header[8] << 8) | chip_header[9]
        # Bank (2 bytes at offset 10)
        bank = (chip_header[10] << 8) | chip_header[11]
        # Load address (2 bytes at offset 12)
        load_addr = (chip_header[12] << 8) | chip_header[13]
        # Data size (2 bytes at offset 14)
        data_size = (chip_header[14] << 8) | chip_header[15]

        if offset + 16 + data_size > len(crt_data):
            print(f"Warning: CHIP package at offset {offset} has data size {data_size} exceeding file size.")
            data_size = len(crt_data) - (offset + 16)

        data = crt_data[offset+16:offset+16+data_size]
        chips.append({
            'type': chip_type,
            'bank': bank,
            'load_addr': load_addr,
            'data': data,
            'size': data_size
        })

        offset += package_len

    if not chips:
        print("Error: No CHIP packets found in the CRT file.")
        return False

    first_load_addr = chips[0]['load_addr']

    # 1. EasyFlash logic (C64, ID 32)
    if machine == "C64" and crt_type == 32:
        # EasyFlash maps blocks to 1MB buffer:
        # (bank * 0x4000) + (0 if load_address == 0x8000 else 0x2000)
        filebuffer = bytearray([0xFF] * 0x100000)
        for chip in chips:
            bank = chip['bank']
            load_hi = chip['load_addr'] >> 8
            load_position = (bank * 0x4000) + (0 if load_hi == 0x80 else 0x2000)
            data = chip['data']
            if load_position + len(data) <= len(filebuffer):
                filebuffer[load_position:load_position+len(data)] = data
        bin_data = bytes(filebuffer)

    # 2. Megabyter logic (C64, ID 38)
    elif machine == "C64" and crt_type == 38:
        # Megabyter maps blocks to 1MB buffer: bank * 0x2000
        filebuffer = bytearray([0xFF] * 0x100000)
        for chip in chips:
            bank = chip['bank']
            load_position = bank * 0x2000
            data = chip['data']
            if load_position + len(data) <= len(filebuffer):
                filebuffer[load_position:load_position+len(data)] = data
        bin_data = bytes(filebuffer)

    # 3. Plus4 Multicart logic (Plus4, ID 4)
    elif machine == "PLUS4" and crt_type == 4:
        # Multicart maps blocks to 4MB buffer:
        # (bank * 0x4000) + (0 if load_address == 0x8000 else 0x200000)
        filebuffer = bytearray([0xFF] * 0x400000)
        for chip in chips:
            bank = chip['bank']
            load_hi = chip['load_addr'] >> 8
            load_position = (bank * 0x4000) + (0 if load_hi == 0x80 else 0x200000)
            data = chip['data']
            if load_position + len(data) <= len(filebuffer):
                filebuffer[load_position:load_position+len(data)] = data
        
        # If size is exactly 0x200000 (2MB), copy second half to 0x100000
        total_size = len(chips) * 0x4000
        if total_size == 0x200000:
            filebuffer[0x100000:0x200000] = filebuffer[0x200000:0x300000]
            bin_data = bytes(filebuffer[:0x200000])
        else:
            bin_data = bytes(filebuffer[:total_size])

    # 4. Standard logic: Concatenate all CHIP packets sequentially
    else:
        bin_data = b"".join(chip['data'] for chip in chips)

    # Write output binary/prg file
    with open(bin_path, 'wb') as f:
        if convert_to_prg:
            # PRG prefix (little-endian 16-bit load address)
            f.write(bytes([first_load_addr & 0xFF, (first_load_addr >> 8) & 0xFF]))
        f.write(bin_data)

    print(f"Successfully converted {crt_path} to {bin_path}")
    print(f"  Machine Class: {machine}")
    print(f"  Cartridge ID: {crt_type}")
    print(f"  Format: {'PRG' if convert_to_prg else 'BIN'}")
    return True

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Convert .CRT Commodore cartridges to raw .BIN/.PRG format using the same logic as cartconv.")
    parser.add_argument("input_file", help="Path to input .CRT file")
    parser.add_argument("output_file", help="Path to output .BIN or .PRG file")
    parser.add_argument("--prg", action="store_true", help="Output as CBM .PRG file (adds a 2-byte load address prefix)")
    
    args = parser.parse_args()
    success = crt_to_bin(args.input_file, args.output_file, args.prg)
    sys.exit(0 if success else 1)
