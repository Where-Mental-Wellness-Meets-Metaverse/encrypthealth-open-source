-- Rights Reserved, Unlicensed
\c postgres
DROP DATABASE IF EXISTS oss_governance;
CREATE DATABASE oss_governance;
\c oss_governance
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE oss_project (
  project_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name text NOT NULL,
  repo_url text NOT NULL
);

CREATE TABLE issue (
  issue_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id uuid NOT NULL REFERENCES oss_project(project_id) ON DELETE CASCADE,
  title text NOT NULL,
  label text,
  status text NOT NULL CHECK (status IN ('open','merged','closed'))
);

CREATE TABLE policy_doc (
  policy_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id uuid NOT NULL REFERENCES oss_project(project_id) ON DELETE CASCADE,
  doc_type text NOT NULL CHECK (doc_type IN ('data-governance','security','contribution')),
  uri text NOT NULL
);

CREATE TABLE version (
  version_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  policy_id uuid NOT NULL REFERENCES policy_doc(policy_id) ON DELETE CASCADE,
  semver text NOT NULL,
  published_at timestamptz NOT NULL DEFAULT now(),
  checksum text
);

CREATE TABLE consent_template (
  template_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name text NOT NULL,
  jurisdiction text NOT NULL,
  fhir_scope text NOT NULL
);

CREATE TABLE presentation_def (
  pd_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  template_id uuid NOT NULL REFERENCES consent_template(template_id) ON DELETE CASCADE,
  spec text NOT NULL CHECK (spec IN ('OIDC4VP','SD-JWT')),
  uri text NOT NULL
);

REVOKE ALL ON SCHEMA public FROM PUBLIC;
