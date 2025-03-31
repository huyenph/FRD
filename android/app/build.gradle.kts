plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
//    id("com.google.gms.google-services")
}

android {
    namespace = "com.hpcompose.frd"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.hpcompose.frd"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    flavorDimensions += "environment"
    productFlavors {
        create("prod") {
            dimension = "environment"
            versionCode = 1
            versionName = "1.0"
            resValue(
                type = "string",
                name = "app_name",
                value = "FRD")
        }
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"
            versionCode = 1
            versionName = "1.0"
            resValue(
                type = "string",
                name = "app_name",
                value = "FRD STAG")
        }
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionCode = 1
            versionName = "1.0"
            resValue(
                type = "string",
                name = "app_name",
                value = "FRD DEV")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
//    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version")
    implementation(platform("com.google.firebase:firebase-bom:33.11.0"))
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("com.facebook.android:facebook-android-sdk:18.0.2")
}
