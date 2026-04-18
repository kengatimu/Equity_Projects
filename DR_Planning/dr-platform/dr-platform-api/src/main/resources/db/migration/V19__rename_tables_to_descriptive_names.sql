-- V19: Rename tables to more descriptive names
--
-- Old name              → New name
-- dependencies          → application_dependencies   (app ↔ resource linking table)
-- dependency_history    → application_dependency_history
-- shared_resources      → infrastructure_resources   (the resource catalog / CMDB-lite)
-- shared_resource_history → infrastructure_resource_history

ALTER TABLE dependencies RENAME TO application_dependencies;
ALTER TABLE dependency_history RENAME TO application_dependency_history;
ALTER TABLE shared_resources RENAME TO infrastructure_resources;
ALTER TABLE shared_resource_history RENAME TO infrastructure_resource_history;
