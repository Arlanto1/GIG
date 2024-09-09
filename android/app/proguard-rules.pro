# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn edu.umd.cs.findbugs.annotations.NonNull
-dontwarn edu.umd.cs.findbugs.annotations.Nullable
-dontwarn edu.umd.cs.findbugs.annotations.SuppressFBWarnings
-dontwarn org.bouncycastle.asn1.ASN1Encodable
-dontwarn org.bouncycastle.asn1.pkcs.PrivateKeyInfo
-dontwarn org.bouncycastle.asn1.x509.AlgorithmIdentifier
-dontwarn org.bouncycastle.asn1.x509.SubjectPublicKeyInfo
-dontwarn org.bouncycastle.cert.X509CertificateHolder
-dontwarn org.bouncycastle.cert.jcajce.JcaX509CertificateHolder
-dontwarn org.bouncycastle.crypto.BlockCipher
-dontwarn org.bouncycastle.crypto.CipherParameters
-dontwarn org.bouncycastle.crypto.InvalidCipherTextException
-dontwarn org.bouncycastle.crypto.engines.AESEngine
-dontwarn org.bouncycastle.crypto.modes.GCMBlockCipher
-dontwarn org.bouncycastle.crypto.params.AEADParameters
-dontwarn org.bouncycastle.crypto.params.KeyParameter
-dontwarn org.bouncycastle.jcajce.provider.BouncyCastleFipsProvider
-dontwarn org.bouncycastle.jce.provider.BouncyCastleProvider
-dontwarn org.bouncycastle.openssl.PEMKeyPair
-dontwarn org.bouncycastle.openssl.PEMParser
-dontwarn org.bouncycastle.openssl.jcajce.JcaPEMKeyConverter
# Preserve MSAL classes
-keep class com.microsoft.identity.** { *; }
-keep class com.azure.identity.** { *; }
-dontwarn com.microsoft.identity.**

# Preserve Nimbus classes
-keep class com.nimbusds.** { *; }
-dontwarn com.nimbusds.**

# Preserve Jackson classes used for JSON parsing
-keep class com.fasterxml.jackson.** { *; }
-dontwarn com.fasterxml.jackson.**

# Prevent stripping classes used for OAuth token handling
-keep class net.minidev.json.** { *; }
-dontwarn net.minidev.json.**

# Preserve Android WebView and browser components
-keep class android.webkit.** { *; }
-keep class android.net.http.SslError { *; }
-keep class org.chromium.** { *; }
