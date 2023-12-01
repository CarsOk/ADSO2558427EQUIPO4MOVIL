class ListOrderDto {
  final int? id;
  final DateTime? fecha;
  final int? consecutivo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? avatarUrl;
  final String? destino;
  final String? origen;
  final String? estado;
  final String? codigoEnvio;
  final String? valor;
  final int? dispatchId;
  final int? companyId;
  final int? userId;

  ListOrderDto({
    required this.id,
    required this.fecha,
    required this.consecutivo,
    required this.createdAt,
    required this.updatedAt,
    required this.avatarUrl,
    required this.destino,
    required this.origen,
    required this.estado,
    required this.codigoEnvio,
    required this.valor,
    required this.dispatchId,
    required this.companyId,
    required this.userId,
  });

  factory ListOrderDto.fromJson(Map<String, dynamic> json) {
    return ListOrderDto(
      id: json['id'],
      fecha: DateTime.parse(json['fecha']),
      consecutivo: json['consecutivo'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      avatarUrl: json['avatar']['url'],
      destino: json['destino'],
      origen: json['origen'],
      estado: json['estado'],
      codigoEnvio: json['codigo_envio'],
      valor: json['valor'],
      dispatchId: json['dispatch_id'],
      companyId: json['company_id'],
      userId: json['user_id'],
    );
  }
}
