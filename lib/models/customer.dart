class Authority {
  final String authority;

  Authority({required this.authority});

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
      authority: json['authority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authority': authority,
    };
  }
}

class Customer {
  final int id;
  final String phone;
  final String name;
  final String email;
  final String password;
  final String role;
  final bool enabled;
  final bool accountNonExpired;
  final bool credentialsNonExpired;
  final List<Authority> authorities;
  final String username;
  final bool accountNonLocked;

  Customer({
    required this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.enabled,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
    required this.authorities,
    required this.username,
    required this.accountNonLocked,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      phone: json['phone'].toString(),
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      enabled: json['enabled'],
      accountNonExpired: json['accountNonExpired'],
      credentialsNonExpired: json['credentialsNonExpired'],
      authorities: (json['authorities'] as List)
          .map((auth) => Authority.fromJson(auth))
          .toList(),
      username: json['username'],
      accountNonLocked: json['accountNonLocked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'enabled': enabled,
      'accountNonExpired': accountNonExpired,
      'credentialsNonExpired': credentialsNonExpired,
      'authorities': authorities.map((auth) => auth.toJson()).toList(),
      'username': username,
      'accountNonLocked': accountNonLocked,
    };
  }
}
