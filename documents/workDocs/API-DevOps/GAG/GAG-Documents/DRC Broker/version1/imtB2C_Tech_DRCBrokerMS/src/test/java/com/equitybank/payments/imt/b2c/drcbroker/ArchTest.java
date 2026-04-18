//package com.equitybank.payments.imt.b2c.drcbroker;
//
//import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;
//
//import com.tngtech.archunit.core.domain.JavaClasses;
//import com.tngtech.archunit.core.importer.ClassFileImporter;
//import com.tngtech.archunit.core.importer.ImportOption;
//import org.junit.jupiter.api.Test;
//
//class ArchTest {
//
//    @Test
//    void servicesAndRepositoriesShouldNotDependOnWebLayer() {
//        JavaClasses importedClasses = new ClassFileImporter()
//            .withImportOption(ImportOption.Predefined.DO_NOT_INCLUDE_TESTS)
//            .importPackages("com.equitybank.payments.imt.b2c.drcbroker");
//
//        noClasses()
//            .that()
//            .resideInAnyPackage("com.equitybank.payments.imt.b2c.drcbroker.service..")
//            .or()
//            .resideInAnyPackage("com.equitybank.payments.imt.b2c.drcbroker.repository..")
//            .should()
//            .dependOnClassesThat()
//            .resideInAnyPackage("..com.equitybank.payments.imt.b2c.drcbroker.web..")
//            .because("Services and repositories should not depend on web layer")
//            .check(importedClasses);
//    }
//}
