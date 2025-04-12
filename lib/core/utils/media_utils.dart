import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MediaUtils {
  static Future<File?> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  static Future<File?> pickVideo(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(minutes: 3),
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking video: $e');
      return null;
    }
  }

  static Widget loadNetworkImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 40);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
        child: const Icon(Icons.error, color: Colors.red),
      ),
    );
  }

  static Widget loadProfileImage(String? imageUrl, {double size = 48}) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey[300],
      backgroundImage: imageUrl != null
          ? CachedNetworkImageProvider(imageUrl)
          : null,
      child: imageUrl == null ? Icon(Icons.person, size: size / 2) : null,
    );
  }
}