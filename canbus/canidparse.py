# Huge thanks to chatgpt for writing this shit for me
# it only made one mistake, which was removing the first 3 bits twice
# nd 10/16/24

# Define lookup tables for Device Types and Manufacturers
DEVICE_TYPES = {
    0: "Broadcast Messages",
    1: "Robot Controller",
    2: "Motor Controller",
    3: "Relay Controller",
    4: "Gyro Sensor",
    5: "Accelerometer",
    6: "Ultrasonic Sensor",
    7: "Gear Tooth Sensor",
    8: "Power Distribution Module",
    9: "Pneumatics Controller",
    10: "Miscellaneous",
    11: "IO Breakout",
    12: "Reserved",
    31: "Firmware Update",
}

MANUFACTURERS = {
    0: "Broadcast",
    1: "NI",
    2: "Luminary Micro",
    3: "DEKA",
    4: "CTR Electronics",
    5: "REV Robotics",
    6: "Grapple",
    7: "MindSensors",
    8: "Team Use",
    9: "Kauai Labs",
    10: "Copperforge",
    11: "Playing With Fusion",
    12: "Studica",
    13: "The Thrifty Bot",
    14: "Redux Robotics",
    15: "AndyMark",
    16: "Vivid Hosting",
    # Reserved IDs: 17-255
}

def parse_can_id(hex_id):
    # Convert hex to binary and remove '0b' prefix
    bin_id = bin(int(hex_id, 16))[2:].zfill(29)  # 29 bits are used
    print(bin_id)

    # Extract the 5-bit device type (bits 0-4)
    device_type_bin = bin_id[:5]
    device_type = int(device_type_bin, 2)

    # Extract the 8-bit manufacturer (bits 5-12)
    manufacturer_bin = bin_id[5:13]
    manufacturer = int(manufacturer_bin, 2)

    # Skip the next 10 bits (bits 13-22)
    # Extract the 6-bit device number (bits 23-28)
    device_number_bin = bin_id[23:29]
    device_number = int(device_number_bin, 2)

    # Output results
    device_type_str = DEVICE_TYPES.get(device_type, "Unknown Device Type")
    manufacturer_str = MANUFACTURERS.get(manufacturer, "Unknown Manufacturer")

    return {
        "Device Type": device_type_str,
        "Manufacturer": manufacturer_str,
        "Device Number": device_number
    }

# Example Usage
while True:
    hex_id = input("Enter the CAN hex ID: ").strip()
    if hex_id == "":
        break
    result = parse_can_id(hex_id)
    print(f"Device Type: {result['Device Type']}")
    print(f"Manufacturer: {result['Manufacturer']}")
    print(f"Device Number: {result['Device Number']}")
    print()
