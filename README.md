# embryo-storage-database-system
# Embryo Storage Database System | Oracle SQL

## Overview

This project is a relational database designed to manage embryo storage data in a fertility clinic environment. It supports structured storage, retrieval, and tracking of patients, embryos, procedures, specialists, and storage tanks.

The system reflects real-world clinical workflows and demonstrates how relational databases can support sensitive healthcare data while maintaining integrity and performance.

## Key Features

* Relational database schema designed using ER modeling principles
* Oracle SQL DDL for table creation, constraints, and relationships
* DML scripts for realistic sample data population
* Indexing for query performance optimization
* Sequences and triggers for automated key generation
* Views for reporting and simplified data access

## Core Entities

* Patients
* Embryos
* Procedures
* Specialists
* Storage Tanks

## Performance & Design

* Implemented indexes on high-frequency query columns
* Enforced referential integrity using foreign keys
* Used constraints to validate and protect data accuracy
* Structured relationships to minimize redundancy

## Business Value

This database simulates a healthcare data system where accuracy, traceability, and structure are critical. It demonstrates how database design supports clinical workflows, improves data organization, and reduces manual errors.

## Tools & Technologies

* Oracle SQL
* SQL Developer
* ER Assistant

## How to Run This Project

1. Run ddl/embryo_storage_ddl.sql
2. Run dml/embryo_storage_dml.sql
3. Run queries/sample_queries.sql
4. Query views and tables to validate results

## Outcome

This project demonstrates real-world database design aligned with healthcare systems, highlighting data integrity, structured workflows, and scalable schema design.
