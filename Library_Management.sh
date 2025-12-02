#!/bin/bash

ADMIN_USER="admin"
ADMIN_PASS="admin"
LOGIN_FILE="login.txt"
BOOKS_FILE="books.txt"
BORROW_FILE="borrowed_books.txt"

initialize_system() {
    if [[ ! -f $LOGIN_FILE ]]; then
        echo "$ADMIN_USER:$ADMIN_PASS" > $LOGIN_FILE
    fi
    if [[ ! -f $BOOKS_FILE ]]; then
        touch $BOOKS_FILE
    fi
    if [[ ! -f $BORROW_FILE ]]; then
        touch $BORROW_FILE
    fi
}


admin_login() {
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo
    local credentials=$(cat $LOGIN_FILE)
    local saved_user=$(echo $credentials | cut -d ':' -f 1) 
    local saved_pass=$(echo $credentials | cut -d ':' -f 2)
    if [[ $username == $saved_user && $password == $saved_pass ]]; then
        echo "Login successful."
        admin_menu
    else
        echo "Login failed."
    fi
}


change_admin_credentials() {
    read -p "Enter new username: " new_user 
    read -sp "Enter new password: " new_pass 
    echo "$new_user:$new_pass" > $LOGIN_FILE
    echo "Credentials updated."
}


admin_menu() {
    while true; do
        echo -e "\n\n\n\tAdmin Menu:"
        echo -e "\t1. Add Book"
        echo -e "\t2. View Books"
        echo -e "\t3. Edit Book"
        echo -e "\t4. Delete Book"
        echo -e "\t5. Change Credentials"
        echo -e "\t6. Exit"
        read -p "Choose an option: " option
        case $option in
            1) add_book ;;
            2) view_books ;;
            3) edit_book ;;
            4) delete_book ;;
            5) change_admin_credentials ;;
            6) break ;;
            *) echo "Invalid option." ;;
        esac
    done
}


add_book() {
    read -p "Enter book name: " book_name
    read -p "Enter author name: " author_name
    echo "$book_name by $author_name, Available" >> $BOOKS_FILE
    echo "Book added."
}


view_books() {
    if [[ ! -s $BOOKS_FILE ]]; then 
        echo "No books available."
    else
        echo -e "\n\nAvailable Books:"
        cat $BOOKS_FILE
    fi
}


edit_book() {
    read -p "Enter the exact book name to edit: " original_name
    if grep -q "$original_name" $BOOKS_FILE; then 
        read -p "Enter the new book name: " new_name
        read -p "Enter the new author name: " new_author
        sed -i "s/^$original_name, .*/$new_name by $new_author, Available/" $BOOKS_FILE 
        echo "Book updated."
    else
        echo "Book not found."
    fi
}


delete_book() {
    read -p "Enter the book name to delete: " book_name
    local exists=$(grep -i "$book_name" $BOOKS_FILE) 
    if [[ -z $exists ]]; then
        echo "Book not found."
    else
        sed -i "/$book_name/d" $BOOKS_FILE
        echo "Book deleted."
    fi
}



user_menu() {
    while true; do
        echo -e "\n\n\n\tUser Menu:"
        echo -e "\t1. View Books"
        echo -e "\t2. Borrow Book"
        echo -e "\t3. Return Book"
        echo -e "\t4. Check Borrowed Books"
        echo -e "\t5. Exit"
        read -p "Choose an option: " option
        case $option in
            1) view_books ;;
            2) borrow_book ;;
            3) return_book ;;
            4) check_borrowed_books ;;
            5) break ;;
            *) echo "Invalid option." ;;
        esac
    done
}


borrow_book() {
    read -p "Enter the exact book name to borrow: " book_name
    if grep -q "$book_name, Available" $BOOKS_FILE; then
        sed -i "s/^$book_name, Available/$book_name, Borrowed/" $BOOKS_FILE
        echo "$book_name, $(date +%Y-%m-%d)" >> $BORROW_FILE
        echo "You have borrowed the book."
    else
        echo "This book is not available for borrowing."
    fi
}


return_book() {
    read -p "Enter the exact book name to return: " book_name
    if grep -q "$book_name, Borrowed" $BOOKS_FILE; then
        sed -i "s/^$book_name, Borrowed/$book_name, Available/" $BOOKS_FILE
        sed -i "/^$book_name,/d" $BORROW_FILE
        echo "You have returned the book."
    else
        echo "This book was not borrowed or does not exist."
    fi
}


check_borrowed_books() {
    echo -e "\n\nBooks you have borrowed:"
    cat $BORROW_FILE
}


main_menu() {
    while true; do
        echo -e "\n\n\n\tMain Menu:"
        echo -e "\t1. Admin Login"
        echo -e "\t2. User Access"
        echo -e "\t3. Exit"
        read -p "Choose an option: " option
        case $option in
            1) admin_login ;;
            2) user_menu ;;
            3) exit ;;
            *) echo "Invalid option." ;;
        esac
    done
}


initialize_system
main_menu
