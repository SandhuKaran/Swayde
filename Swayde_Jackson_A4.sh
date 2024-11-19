#!/bin/bash
# SYST15123 - Assignment #04
# Swayde Jackson
# Swayde_Jackson_A4

# Filename of the CD collection
collection_file="Swayde_Jackson_music"

# Function to display the menu
display_menu() {
    echo "------------------------------------"
    echo "CD Collection Menu:"
    echo "1. View the contents of the music collection file"
    echo "2. View the cost of the entire collection"
    echo "3. Search for all CDs from a particular artist"
    echo "4. Search for all CDs purchased on a specific date"
    echo "5. Exit"
    echo "------------------------------------"
}

# Main loop
while true; do
    display_menu
    read -p "Please enter your choice (1-5): " choice

    case $choice in
        1)
            # Option 1: View the contents of the music collection file
            echo "Contents of the music collection:"
            cat "$collection_file"
            ;;
        2)
            # Option 2: View the cost of the entire collection
            total_cost=$(awk -F';' '{gsub(/ /,"",$4); sum += $4} END {print sum}' "$collection_file")
            echo "The total cost of the collection is: $total_cost"
            ;;
        3)
            # Option 3: Search for all CDs from a particular artist
            read -p "Enter the artist name: " artist_name
            matches=$(awk -F';' -v name="$artist_name" 'BEGIN{IGNORECASE=1} $1 == name' "$collection_file")
            if [ -z "$matches" ]; then
                echo "Nothing is found for the artist specified"
            else
                echo "CDs by $artist_name:"
                echo "$matches"
            fi
            ;;
        4)
            # Option 4: Search for all CDs purchased on a specific date
            read -p "Enter the purchase date (e.g., March 15, 2021): " purchase_date
            matches=$(awk -F';' -v date="$purchase_date" 'BEGIN{IGNORECASE=1} $3 == date' "$collection_file")
            if [ -z "$matches" ]; then
                echo "Nothing is found for the date specified"
            else
                echo "CDs purchased on $purchase_date:"
                echo "$matches"
            fi
            ;;
        5)
            # Option 5: Exit
            read -p "Are you sure you want to exit? (y/n): " confirm_exit
            if [[ "$confirm_exit" =~ ^[Yy]$ ]]; then
                echo "Exiting the script. Goodbye!"
                exit 0
            else
                echo "Continuing..."
            fi
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 5."
            ;;
    esac
    echo ""  # Add a blank line for readability
done