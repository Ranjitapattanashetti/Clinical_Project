This project demonstrates practical experience with clinical data standards using CDISC SDTM and ADaM, covering the end-to-end clinical data workflow in SAS Studio (OnDemand) from CRF Excel data through analysis-ready outputs.

Tools & Standards Used:

SAS Studio (OnDemand for Academics)
CDISC SDTM
CDISC ADaM
SDTM Implementation Guide
Excel (CRF data)
ODS PDF for reporting

Workflow:

CRF Data Preparation
CRF data maintained in Excel format
One sheet per CRF domain
Import CRF into SAS
Used PROC IMPORT to load Excel data into SAS
SDTM Mapping
Mapping defined in Excel (CRF variable → SDTM variable)
Included derivations and controlled terminology
SDTM Dataset Creation
Created SDTM DM dataset using SAS DATA step
Converted dates to ISO 8601 format
Derived USUBJID and assigned DOMAIN
XPT Conversion
Exported SDTM dataset to XPT format using XPORT engine
ADaM Dataset Creation
Created ADSL from SDTM DM
Derived AGE and analysis flags
Analysis
Subject count
Gender-wise distribution
Age summary statistics
Documentation
Exported SAS outputs to PDF using ODS PDF

Datasets Created:

SDTM
DM (Demographics)
ADaM
ADSL (Subject-Level Analysis Dataset)

Sample Analyses:

Total subject count
Sex distribution
Age summary (mean, min, max)

 Disclaimer:

This project uses dummy data created for learning and demonstration purposes only.
It does not contain real patient data.
