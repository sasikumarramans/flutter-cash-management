# CRITICAL: Keep generic signatures for TypeToken and Gson
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Keep ALL flutter_local_notifications classes (prevents obfuscation issues)
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keepclassmembers class com.dexterous.flutterlocalnotifications.** { *; }

# Keep Gson completely (required for notification data serialization)
-keep class com.google.gson.** { *; }
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken

# Prevent obfuscation of classes used by TypeToken
-keep class * implements java.lang.reflect.ParameterizedType { *; }

# Keep serialization annotations and fields
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}
-keep,allowobfuscation @interface com.google.gson.annotations.SerializedName

# Keep notification data models and constructors
-keep class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Additional protection for reflection-based operations
-keepclassmembers class * {
    @com.google.gson.annotations.Expose <fields>;
}

# Keep method names that might be called via reflection
-keepclassmembers class com.dexterous.flutterlocalnotifications.** {
    public <methods>;
    public <fields>;
}