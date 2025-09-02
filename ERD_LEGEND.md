# OSS Governance ERD — Legend (Public)

| Table                | Purpose                                                                 |
|----------------------|-------------------------------------------------------------------------|
| **oss_project**      | Represents an open-source project (e.g., OpenMRS, mydata-did-consent). |
| **issue**            | Tracks issues, tasks, or feature requests tied to an OSS project.      |
| **policy_doc**       | Data governance, security, or contribution policy linked to a project. |
| **version**          | Version history of a policy document (semver + checksum).              |
| **consent_template** | Template for DID/FHIR-based consent across jurisdictions.              |
| **presentation_def** | Technical definitions (OIDC4VP, SD-JWT) tied to a consent template.    |
