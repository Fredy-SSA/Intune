#!/bin/bash

# Set variables
BASE_VM_ID=200  # Starting ID for the VMs created by the previous script
NUM_VMS=10      # Number of VMs to delete

# Function to delete a single VM
delete_vm() {
  VM_ID=$1

  # Check if the VM exists
  if qm status $VM_ID &>/dev/null; then
    echo "Stopping VM ID $VM_ID..."
    qm stop $VM_ID

    echo "Deleting VM ID $VM_ID..."
    qm destroy $VM_ID

    echo "VM ID $VM_ID deleted successfully."
  else
    echo "VM ID $VM_ID does not exist. Skipping..."
  fi
}

# Ask the user for the number of VMs to delete (optional)
read -p "Enter the number of VMs to delete (default is $NUM_VMS): " input_num_vms
if [[ -n "$input_num_vms" ]]; then
  NUM_VMS=$input_num_vms
fi

# Delete the specified number of VMs
for ((i=0; i<$NUM_VMS; i++))
do
  VM_ID=$((BASE_VM_ID + i))
  delete_vm $VM_ID
done

echo "Cleanup completed."