// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiApiKey _$AiApiKeyFromJson(Map<String, dynamic> json) => _AiApiKey(
      id: json['id'] as String,
      key: json['key'] as String,
      enabled: json['enabled'] as bool? ?? true,
      label: json['label'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AiApiKeyToJson(_AiApiKey instance) => <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'enabled': instance.enabled,
      'label': instance.label,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_AiProvider _$AiProviderFromJson(Map<String, dynamic> json) => _AiProvider(
      id: json['id'] as String,
      title: json['title'] as String,
      logoAsset: json['logoAsset'] as String?,
      url: json['url'] as String,
      protocol: _$enumDecode(_$AiProtocolEnumMap, json['protocol']),
      enabled: json['enabled'] as bool? ?? true,
      isBuiltin: json['isBuiltin'] as bool? ?? false,
      apiKeys: (json['apiKeys'] as List<dynamic>?)
              ?.map((e) => AiApiKey.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      model: json['model'] as String? ?? '',
      reasoningEffort: json['reasoningEffort'] == null
          ? AiReasoningEffort.auto
          : _$enumDecode(_$AiReasoningEffortEnumMap, json['reasoningEffort']),
      keyIndex: json['keyIndex'] as int? ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AiProviderToJson(_AiProvider instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'logoAsset': instance.logoAsset,
      'url': instance.url,
      'protocol': _$AiProtocolEnumMap[instance.protocol],
      'enabled': instance.enabled,
      'isBuiltin': instance.isBuiltin,
      'apiKeys': instance.apiKeys.map((e) => e.toJson()).toList(),
      'model': instance.model,
      'reasoningEffort': _$AiReasoningEffortEnumMap[instance.reasoningEffort],
      'keyIndex': instance.keyIndex,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$AiProtocolEnumMap = {
  AiProtocol.openai: 'openai',
  AiProtocol.claude: 'claude',
  AiProtocol.gemini: 'gemini',
};

const _$AiReasoningEffortEnumMap = {
  AiReasoningEffort.auto: 'auto',
  AiReasoningEffort.low: 'low',
  AiReasoningEffort.medium: 'medium',
  AiReasoningEffort.high: 'high',
};

T _$enumDecode<T>(Map<T, String> enumMap, String value) {
  return enumMap.entries
      .firstWhere((element) => element.value == value,
          orElse: () => enumMap.entries.first)
      .key;
}
