import 'package:mysql_client/mysql_client.dart';
import '../model/poli.dart';
import '../model/pegawai.dart';
import '../model/pasien.dart';

/// Koneksi langsung ke MySQL/MariaDB asli.
///
/// PENTING: hanya jalan di Android / iOS / Linux / Windows / macOS.
/// TIDAK bisa jalan di Web (Chrome/Brave) karena browser tidak boleh
/// membuka TCP socket. Untuk web harus lewat REST API.
/// Jalankan app dengan: flutter run -d linux
class DbService {
  static final DbService _instance = DbService._internal();
  factory DbService() => _instance;
  DbService._internal();

  MySQLConnectionPool? _pool;

  // Kalau jalan di emulator Android, ganti host jadi '10.0.2.2'.
  // Kalau MySQL di container/podman dengan -p 3306:3306, 127.0.0.1 bisa.
  static const _host = '127.0.0.1';
  static const _port = 3306;
  static const _user = 'root';
  static const _password = 'root';
  static const _db = 'klinik';

  MySQLConnectionPool get pool {
    _pool ??= MySQLConnectionPool(
      host: _host,
      port: _port,
      userName: _user,
      password: _password,
      maxConnections: 5,
      databaseName: _db,
      secure: false,
    );
    return _pool!;
  }

  Future<void> close() async {
    await _pool?.close();
    _pool = null;
  }

  // ---------- POLI ----------
  Future<List<Poli>> getPoliList() async {
    final result =
        await pool.execute('SELECT id, nama_poli FROM poli ORDER BY id');
    return result.rows
        .map((row) => Poli(
              id: int.tryParse(row.colAt(0) ?? ''),
              namaPoli: row.colAt(1) ?? '',
            ))
        .toList();
  }

  Future<int> insertPoli(String namaPoli) async {
    final result = await pool.execute(
      'INSERT INTO poli (nama_poli) VALUES (:nama)',
      {'nama': namaPoli},
    );
    return result.lastInsertID.toInt();
  }

  Future<void> updatePoli(int id, String namaPoli) async {
    await pool.execute(
      'UPDATE poli SET nama_poli = :nama WHERE id = :id',
      {'nama': namaPoli, 'id': id},
    );
  }

  Future<void> deletePoli(int id) async {
    await pool.execute('DELETE FROM poli WHERE id = :id', {'id': id});
  }

  // ---------- PEGAWAI ----------
  Future<List<Pegawai>> getPegawaiList() async {
    final result = await pool.execute(
        'SELECT id, nip, nama, tanggal_lahir, nomor_telepon, email, password '
        'FROM pegawai ORDER BY id');
    return result.rows
        .map((row) => Pegawai(
              id: int.tryParse(row.colAt(0) ?? ''),
              nip: row.colAt(1) ?? '',
              nama: row.colAt(2) ?? '',
              tanggalLahir: row.colAt(3) ?? '',
              nomorTelepon: row.colAt(4) ?? '',
              email: row.colAt(5) ?? '',
              password: row.colAt(6) ?? '',
            ))
        .toList();
  }

  Future<int> insertPegawai(Pegawai p) async {
    final result = await pool.execute(
      'INSERT INTO pegawai (nip, nama, tanggal_lahir, nomor_telepon, email, password) '
      'VALUES (:nip, :nama, :tgl, :telp, :email, :pwd)',
      {
        'nip': p.nip,
        'nama': p.nama,
        'tgl': p.tanggalLahir,
        'telp': p.nomorTelepon,
        'email': p.email,
        'pwd': p.password,
      },
    );
    return result.lastInsertID.toInt();
  }

  Future<void> updatePegawai(Pegawai p) async {
    await pool.execute(
      'UPDATE pegawai SET nip = :nip, nama = :nama, tanggal_lahir = :tgl, '
      'nomor_telepon = :telp, email = :email, password = :pwd WHERE id = :id',
      {
        'nip': p.nip,
        'nama': p.nama,
        'tgl': p.tanggalLahir,
        'telp': p.nomorTelepon,
        'email': p.email,
        'pwd': p.password,
        'id': p.id,
      },
    );
  }

  Future<void> deletePegawai(int id) async {
    await pool.execute('DELETE FROM pegawai WHERE id = :id', {'id': id});
  }

  // ---------- PASIEN ----------
  Future<List<Pasien>> getPasienList() async {
    final result = await pool.execute(
        'SELECT id, nomor_rm, nama, tanggal_lahir, nomor_telepon, alamat '
        'FROM pasien ORDER BY id');
    return result.rows
        .map((row) => Pasien(
              id: int.tryParse(row.colAt(0) ?? ''),
              nomorRm: row.colAt(1) ?? '',
              nama: row.colAt(2) ?? '',
              tanggalLahir: row.colAt(3) ?? '',
              nomorTelepon: row.colAt(4) ?? '',
              alamat: row.colAt(5) ?? '',
            ))
        .toList();
  }

  Future<int> insertPasien(Pasien p) async {
    final result = await pool.execute(
      'INSERT INTO pasien (nomor_rm, nama, tanggal_lahir, nomor_telepon, alamat) '
      'VALUES (:rm, :nama, :tgl, :telp, :alamat)',
      {
        'rm': p.nomorRm,
        'nama': p.nama,
        'tgl': p.tanggalLahir,
        'telp': p.nomorTelepon,
        'alamat': p.alamat,
      },
    );
    return result.lastInsertID.toInt();
  }

  Future<void> updatePasien(Pasien p) async {
    await pool.execute(
      'UPDATE pasien SET nomor_rm = :rm, nama = :nama, tanggal_lahir = :tgl, '
      'nomor_telepon = :telp, alamat = :alamat WHERE id = :id',
      {
        'rm': p.nomorRm,
        'nama': p.nama,
        'tgl': p.tanggalLahir,
        'telp': p.nomorTelepon,
        'alamat': p.alamat,
        'id': p.id,
      },
    );
  }

  Future<void> deletePasien(int id) async {
    await pool.execute('DELETE FROM pasien WHERE id = :id', {'id': id});
  }
}
