# School Library

![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-3670A0?style=for-the-badge&logo=MySQL&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![XAMPP](https://img.shields.io/badge/XAMPP-ff7f00?style=for-the-badge&logo=xampp&logoColor=white)
![Apache](https://img.shields.io/badge/apache-%23D42029.svg?style=for-the-badge&logo=apache&logoColor=white)


Github repository of National School Library Database System.


# Εγκατάσταση

## Manual Installation
Θα χρειαστούμε το πρόγραμμα `XAMPP Control Panel` και το `MySQL Workbench`.
#### Database:
Ανοίγουμε πρόγραμμα ή server που μπορεί να κάνει host βάση MariaDB/MySQL. Δημιουργούμε μια βάση με το όνομα `mydb`.

```bash
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
```

Κάνουμε import το DB dump στην βάση (είτε μέσω PHPMyAdmin ή απευθείας από το MariaDB)
```bash
mariadb -u root -p `path for db schema`
```
