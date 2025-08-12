#!/bin/bash

# Set variables
TEMPLATE_ID=101
TEMPLATE_NAME="Template W11"
BASE_VM_ID=200  # Starting ID for new VMs
CLONE_STORAGE="local-lvm"  # Storage where the VM disks will be stored
NODE_NAME="pve"  # Name of the Proxmox node

# Function to create a single VM from the template
create_vm() {
  VM_ID=$1
  VM_NAME="VM-$VM_ID"

  echo "Creating VM ID $VM_ID from template $TEMPLATE_NAME (ID: $TEMPLATE_ID)..."
  qm clone $TEMPLATE_ID $VM_ID --name $VM_NAME --full --storage $CLONE_STORAGE
  qm start $VM_ID

  echo "VM $VM_NAME created and started successfully."
}

# Ask the user for the number of VMs to create
read -p "Enter the number of VMs to create (1-10 or more): " NUM_VMS

# Validate the input
if ! [[ "$NUM_VMS" =~ ^[0-9]+$ ]]; then
  echo "Invalid number. Please enter a valid number."
  exit 1
fi

# Create the specified number of VMs
for ((i=0; i<$NUM_VMS; i++))
do
  VM_ID=$((BASE_VM_ID + i))
  create_vm $VM_ID
done

echo "All specified VMs have been created and started."