plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
 //   id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}
import java.util.Properties
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}


println(">>> storeFile: " + keystoreProperties["storeFile"])

println(">>> exists: " + rootProject.file(keystoreProperties["storeFile"] as String?).exists())
android {
    namespace = "com.nabhiverse.superapp"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {

        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.nabhiverse.superapp"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 26
        targetSdk = 36
        versionCode = 5
        versionName = "5"

        multiDexEnabled = true
    }
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")

            isMinifyEnabled = false
            isShrinkResources = false


        }
    }
}



dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.core:core:1.16.0")
    implementation("androidx.core:core-ktx:1.17.0")
    implementation("androidx.multidex:multidex:2.0.1")
//    implementation("com.guardsquare:proguard-annotations:7.4.1")
}

flutter {
    source = "../.."
}
