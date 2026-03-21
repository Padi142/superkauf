class PresignedUploadData {
  final String key;
  final String uploadUrl;
  final String publicUrl;

  const PresignedUploadData({
    required this.key,
    required this.uploadUrl,
    required this.publicUrl,
  });

  factory PresignedUploadData.fromJson(Map<String, dynamic> json) {
    return PresignedUploadData(
      key: json['key'] as String,
      uploadUrl: json['uploadUrl'] as String,
      publicUrl: json['publicUrl'] as String,
    );
  }
}
