//ignore_for_file: todo
import 'dart:convert';
import 'package:http/http.dart' as http;

var _linkPath = "http://kostsoda.onthewifi.com:3333/";

//user
class ServicesUser {
  Future inputRegistUser(
    nama_user,
    telp_user,
    email_user,
    username_user,
    password_user,
    status_user,
  ) async {
    final response = await http.post(
      Uri.parse(
          "${_linkPath}user/sign-up?nama_user=$nama_user&telp_user=$telp_user&email_user=$email_user&username_user=$username_user&password_user=$password_user&status_user=$status_user"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future getLogin(username_user, password_user) async {
    final response = await http.get(
      Uri.parse(
          "${_linkPath}user/login?username_user=$username_user&password_user=$password_user"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future getProfile(id_user) async {
    final response = await http.get(
      Uri.parse("${_linkPath}user/get-profile?id_user=$id_user"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future updateProfileUser(id_user, nama_user, telp_user, email_user) async {
    final response = await http.put(
      Uri.parse(
          "${_linkPath}user/edit-profile?id_user=$id_user&nama_user=$nama_user&telp_user=$telp_user&email_user=$email_user"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengupdate data");
    }
  }

  Future getAllCatering() async {
    final response = await http.get(
      Uri.parse("${_linkPath}cat/read-awal-cat"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future getCekMaps(id_catering) async {
    final response = await http.get(
      Uri.parse("${_linkPath}MP/read-maps?id_catering=$id_catering"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future getDetailCatering(id_catering) async {
    final response = await http.get(
      Uri.parse("${_linkPath}cat/read-cat?id-catering=$id_catering"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future getMapPengantar(id_user) async {
    final response = await http.get(
      Uri.parse("${_linkPath}PA/read-maps-pengantar?id_user=$id_user"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }
}

//catering
class ServicesCatering {
  Future inputRegistCatering(id_user, nama_catering, alamat_catering,
      telp_catering, email_catering, deskripsi_catering, tipe_pemesanan) async {
    final response = await http.post(
      Uri.parse(
          "${_linkPath}cat/input-catering?id_user=$id_user&nama_catering=$nama_catering&alamat_catering=$alamat_catering&telp_catering=$telp_catering&email_catering=$email_catering&deskripsi_catering=$deskripsi_catering&tipe_pemesanan=$tipe_pemesanan"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future deleteMenu(id_catering, id_menu, tanggal_menu) async {
    final response = await http.delete(
      Uri.parse(
          "${_linkPath}mn/Delete_Menu?id_catering=$id_catering&id_menu=$id_menu&tanggal_menu=$tanggal_menu"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal menghapus data");
    }
  }

  Future inputMenuCatering(
    id_catering, nama_menu, harga_menu, tanggal_menu, jam_pengiriman_awal, jam_pengiriman_akhir, status
  ) async {
    final response = await http.post(
      Uri.parse(
          "${_linkPath}mn/input-menu?id_catering=$id_catering&nama_menu=$nama_menu&harga_menu=$harga_menu&tanggal_menu=$tanggal_menu&jam_pengiriman_awal=$jam_pengiriman_awal&jam_pengiriman_akhir=$jam_pengiriman_akhir&status=$status"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future inputSetLokasi(id_catering, longtitude, langtitude,
      radius) async {
    final response = await http.post(
      Uri.parse(
          "${_linkPath}MP/input-maps?id_catering=$id_catering&longtitude=$longtitude&langtitude=$langtitude&radius=$radius"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future inputOrder(id_user, id_catering, id_menu, nama_menu,harga_menu, tanggal_menu, tanggal_order, status_order, longtitude, langtitude
      ) async {
    final response = await http.post(
      Uri.parse(
          "${_linkPath}ORD/input-order?id_user=$id_user&id_catering=$id_catering&id_menu=$id_menu&nama_menu=$nama_menu&harga_menu=$harga_menu&tanggal_menu=$tanggal_menu&tanggal_order=$tanggal_order&status_order=$status_order&longtitude=$longtitude&langtitude=$langtitude"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future getProfileCatering(id_catering) async {
    final response = await http.get(
      Uri.parse("${_linkPath}cat/read-profile-cat?id_user=$id_catering"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future getMenuCatering(id_catering, tanggal_menu) async {
    final response = await http.get(
      Uri.parse("${_linkPath}mn/read-menu?id_catering=$id_catering&tanggal_menu=$tanggal_menu"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future updateMenu(id_catering, id_menu, nama_menu, harga_menu, tanggal_menu, jam_pengiriman_awal, jam_pengiriman_akhir) async {
    final response = await http.put(
      Uri.parse(
          "${_linkPath}mn/update-menu?id_catering=$id_catering&id_menu=$id_menu&nama_menu=$nama_menu&harga_menu=$harga_menu&tanggal_menu=$tanggal_menu&jam_pengiriman_awal=$jam_pengiriman_awal&jam_pengiriman_akhir=$jam_pengiriman_akhir"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengupdate data");
    }
  }

  Future updateProfileCatering(id_catering, nama_catering, alamat_catering, telp_catering, email_catering, deskripsi_catering) async {
    final response = await http.put(
      Uri.parse(
          "${_linkPath}cat/edit-prof-cat?id_catering=$id_catering&nama_catering=$nama_catering&alamat_catering=$alamat_catering&telp_catering=$telp_catering&email_catering=$email_catering&deskripsi_catering=$deskripsi_catering"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengupdate data");
    }
  }
}

//pengantar
class ServicesPengantar {
  Future inputRegistPengantar(id_catering, nama_pengantar,
      telp_pengantar, email_pengantar, username_pengantar, password_pengantar, status_user) async {
    final response = await http.post(
      Uri.parse(
          "${_linkPath}PA/su-pengantar?id_catering=$id_catering&nama_user=$nama_pengantar&telp_user=$telp_pengantar&email_user=$email_pengantar&username_user=$username_pengantar&password_user=$password_pengantar&status_user=$status_user"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future updateProfileCatering(id_user, langtitude, longtitude) async {
    final response = await http.put(
      Uri.parse(
          "${_linkPath}PA/update-maps-pengantar?id_user=$id_user&langtitude=$langtitude&longtitude=$longtitude"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      return [jsonRespStatus, jsonRespMessage];
    } else {
      throw Exception("Gagal mengupdate data");
    }
  }
}
