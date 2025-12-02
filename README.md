# Library Management System 📚

A lightweight command-line library management system built with Bash scripting. This project provides a simple yet functional interface for managing book inventories and tracking borrowed books.

## Features

### Admin Features

- **Secure Login**: Password-protected admin access
- **Book Management**: Add, view, edit, and delete books from the library
- **Credential Management**: Change admin username and password
- **Inventory Control**: Full control over library collection

### User Features

- **Browse Books**: View all available books in the library
- **Borrow Books**: Check out available books
- **Return Books**: Return borrowed books to the library
- **Track Borrowing**: View personal borrowing history with dates

## Project Structure

```
.
├── Library_Management.sh    # Main script
├── books.txt               # Book inventory database
├── borrowed_books.txt      # Borrowed books records
├── login.txt              # Admin credentials (encrypted storage recommended)
└── README.md              # Project documentation
```

## Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/bash-library-management-system.git
cd bash-library-management-system
```

2. Make the script executable:

```bash
chmod +x Library_Management.sh
```

3. Run the script:

```bash
bash Library_Management.sh
```

## Usage

### First Time Setup

- Default admin credentials: `admin:admin`
- Change these credentials immediately after first login for security

### Admin Access

1. Select "Admin Login" from the main menu
2. Enter admin credentials
3. Manage books, edit inventory, or update credentials

### User Access

1. Select "User Access" from the main menu
2. Browse available books
3. Borrow or return books as needed

## File Format

**books.txt**

```
BookName by AuthorName, Status
```

**borrowed_books.txt**

```
BookName, YYYY-MM-DD
```

**login.txt**

```
username:password
```

## Requirements

- Bash shell (Linux/Unix/MacOS/Git Bash on Windows)
- Basic Unix utilities (grep, sed, cat)

## Security Note

⚠️ **Important**: This is a basic educational project. The current implementation stores credentials in plain text, which is **not secure** for production use. For real-world applications:

- Implement proper password hashing
- Use database systems instead of text files
- Add user authentication tokens
- Implement proper file permissions

## Future Enhancements

- [ ] Add password hashing for secure credential storage
- [ ] Implement due dates and late fee calculation
- [ ] Add search functionality for books
- [ ] Support multiple user accounts
- [ ] Add book categories and filtering
- [ ] Generate borrowing reports
- [ ] Email notifications for due dates

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Author

Created as a learning project to demonstrate Bash scripting capabilities for file handling, user authentication, and menu-driven interfaces.

---

**Note**: This is an educational project designed to demonstrate Bash scripting fundamentals including file I/O, conditional logic, and user interaction.
