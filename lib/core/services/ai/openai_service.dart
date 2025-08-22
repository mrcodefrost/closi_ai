import 'dart:io';
import 'dart:convert';
import 'package:dart_openai/dart_openai.dart';
import 'package:logger/logger.dart';

class OpenAIService {
  static final Logger _logger = Logger();
  
  static void initialize() {
    // Initialize with API key from environment
    OpenAI.apiKey = const String.fromEnvironment(
      'OPENAI_API_KEY',
      defaultValue: '',
    );
    OpenAI.requestsTimeOut = const Duration(seconds: 60);
  }
  
  /// Generate 100-200 semantic metatags for a clothing item image
  static Future<List<String>> generateMetaTags(File imageFile) async {
    try {
      // Convert image to base64
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);
      
      final response = await OpenAI.instance.chat.create(
        model: "gpt-4-vision-preview",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.system,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                '''You are a fashion AI that generates detailed semantic tags for clothing items.
                Generate 100-200 specific tags that cover:
                - Item type and category
                - Colors (primary, secondary, accents)
                - Patterns and prints
                - Material and texture
                - Style descriptors
                - Occasion suitability
                - Season compatibility
                - Brand style similarities
                - Fashion trends
                - Fit and silhouette
                - Details (buttons, zippers, pockets, etc.)
                - Care instructions hints
                - Price range indicators
                - Cultural/regional styles
                
                Return tags as a JSON array of strings.
                Make tags specific and searchable.
                Include both general and specific descriptors.'''
              ),
            ],
          ),
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                "Generate comprehensive semantic tags for this clothing item:"
              ),
              OpenAIChatCompletionChoiceMessageContentItemModel.image(
                imageUrl: OpenAIChatCompletionChoiceMessageImageUrlModel(
                  url: 'data:image/jpeg;base64,$base64Image',
                ),
              ),
            ],
          ),
        ],
        maxTokens: 2000,
        temperature: 0.7,
      );
      
      final content = response.choices.first.message.content?.first.text ?? '[]';
      final tags = List<String>.from(json.decode(content));
      
      _logger.i('Generated ${tags.length} tags for image');
      return tags;
    } catch (e) {
      _logger.e('Error generating meta tags: $e');
      return _generateFallbackTags();
    }
  }
  
  /// Generate outfit recommendations based on wardrobe items
  static Future<List<Map<String, dynamic>>> generateOutfitRecommendations({
    required List<Map<String, dynamic>> wardrobeItems,
    String? occasion,
    String? weather,
    String? style,
  }) async {
    try {
      final prompt = '''
      Based on these wardrobe items: ${json.encode(wardrobeItems)}
      ${occasion != null ? 'Occasion: $occasion' : ''}
      ${weather != null ? 'Weather: $weather' : ''}
      ${style != null ? 'Style preference: $style' : ''}
      
      Generate 5 outfit combinations with reasoning.
      Return as JSON array with structure:
      [{
        "name": "Outfit name",
        "itemIds": ["id1", "id2"],
        "description": "Why this works",
        "occasion": "suitable for",
        "style": "style category"
      }]
      ''';
      
      final response = await OpenAI.instance.chat.create(
        model: "gpt-4-turbo-preview",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.system,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                "You are a professional fashion stylist AI."
              ),
            ],
          ),
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
            ],
          ),
        ],
        temperature: 0.8,
      );
      
      final content = response.choices.first.message.content?.first.text ?? '[]';
      return List<Map<String, dynamic>>.from(json.decode(content));
    } catch (e) {
      _logger.e('Error generating outfit recommendations: $e');
      return [];
    }
  }
  
  /// Fallback tags when API fails
  static List<String> _generateFallbackTags() {
    return [
      'clothing', 'fashion', 'wardrobe', 'style', 'outfit',
      'casual', 'formal', 'comfortable', 'trendy', 'classic'
    ];
  }
}
