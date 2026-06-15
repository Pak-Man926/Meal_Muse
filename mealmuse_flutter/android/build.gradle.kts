allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// 1. We put the namespace patch HERE, before evaluationDependsOn
subprojects {
    afterEvaluate {
        // Only apply this to Android libraries (like the outdated device_info package)
        if (project.plugins.hasPlugin("com.android.library")) {
            project.configure<com.android.build.gradle.LibraryExtension> {
                if (namespace == null) {
                    namespace = project.group.toString()
                }
            }
        }
    }
}

// 2. Flutter's evaluation rule must come AFTER the afterEvaluate block
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}