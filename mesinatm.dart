import 'dart:io';
  // Import library dart:io agar program bisa membaca input dari keyboard (stdin) dan menampilkan teks (stdout).

  // Declare Tampilan Awal Tampilan Menu
void tampilMenu() {
    print('=====================');
    print('BANK SERBA ADA');
    print('=====================');
    print('1. Cek Saldo');
    print('2. Setor Tunai');
    print('3. Tarik Tunai');
    print('4. Keluar');
    print('=====================');
  }

    // Function tampilMenu() dibuat sekali lalu dipanggil berulang kali di dalam while, supaya menu tampil lagi setiap selesai transaksi.
    // Command print() untuk menampilkan teks ke layar.

var ATM = false;
  // Variabel global bertipe boolean sebagai "saklar" mesin ATM. false = ATM mati/belum login, true = ATM menyala/sudah login.
int saldo = 2000000;
  // Variabel global bertipe int untuk menyimpan saldo awal Rp2.000.000. Dibuat di luar main() agar nilainya tetap tersimpan selama program berjalan.

void main(){
  print('=====================');
  print('BANK SERBA ADA');
  print('=====================');
  stdout.writeln('Masukkan PIN Anda : ');
    // Command stdout.writeln untuk menampilkan teks yang bisa diketik.
  var password = stdin.readLineSync();
    // Variabel stdin.readLineSync() untuk membaca PIN yang diketik. Hasilnya bisa null, sehingga harus dicek dulu.

  // ========= LOGIN ========= //
    var percobaan = 0;
      // Menghitung berapa kali PIN sudah dicoba.

    while (!ATM && percobaan < 3) {
      // Login berulang selama belum berhasil (ATM masih false) dan percobaan belum 3 kali.
      stdout.write('Masukkan PIN Anda : ');
      var password = stdin.readLineSync();

      if (password == null || password.trim().isEmpty) {
        print('Mohon masukkan PIN.');
        percobaan++;
        continue;
          // Sekarang continue valid karena berada di dalam while. Kembali ke awal login.
      }

      int? passInt = int.tryParse(password.trim());
        // tryParse dipakai supaya input huruf tidak error, hasilnya null.

      if (passInt == 112233) {
        print('');
        print('Selamat Datang');
        ATM = true;
          // PIN benar, ATM menyala, perulangan login berhenti karena !ATM jadi false.
      } else {
        percobaan++;
        print('PIN salah. Sisa percobaan : ${3 - percobaan}');
        print('');
      }
    }

    if (!ATM) {
      print('Percobaan habis. Kartu diblokir.');
      return;
        // Jika 3 kali gagal, ATM masih false, program berhenti dengan return.
    }

    // ========= PROGRAM MESIN ATM ========= //
    while (ATM) {
      // Perulangan while berjalan terus selama ATM bernilai true, sehingga menu muncul kembali setelah setiap transaksi.
      tampilMenu();
        // Memanggil function tampilMenu() untuk menampilkan daftar menu.
      stdout.writeln('Pilihan Menu (1/2/3) : ');
        // Command stdout.writeln untuk menampilkan teks yang bisa diketik.
      var pilihMenu = stdin.readLineSync();
        // Variabel stdin.readLineSync() untuk membaca nomor menu yang diketik.
        
      if (pilihMenu == '1') {
        print('');
        print('=====================');
        print('SALDO SAAT INI : Rp$saldo');
          // Menampilkan isi variabel saldo. Tanda $ dipakai untuk menyisipkan nilai variabel ke dalam teks (string interpolation).
      };

      if (pilihMenu == '2') {
        print('');
        stdout.writeln('Jumlah yang disetor : Rp');
        var setoran = stdin.readLineSync();
          // Variabel stdin.readLineSync() untuk membaca nominal setoran yang diketik.

        if (setoran == null || setoran.trim().isEmpty) {
          print('Mohon masukkan nominal.');
          print('');
          return;
        }
          // Jika nominal null atau kosong, tampilkan notifikasi lalu program berhenti dengan return.

        try {
          int jumlahSetoran = int.parse(setoran.trim());
            // Mengubah teks nominal menjadi angka agar bisa dihitung.
          int hasilSaldo = saldo + jumlahSetoran;
            // Variabel hasilSaldo menampung hasil penjumlahan saldo lama dengan jumlah setoran.
          saldo = hasilSaldo;
            // Memperbarui variabel saldo dengan hasil penjumlahan tadi.

          print('');
          print('Saldo sekarang : Rp$saldo');
            // Menampilkan saldo terbaru setelah setor tunai.
        } catch (e) {
          print('Input tidak valid. Harap masukkan angka');
          // Blok catch menangkap error jika nominal yang diketik bukan angka.
        }
      }

      if (pilihMenu == '3') {
        // Blok ini hanya berjalan jika pengguna memilih menu 3 (Tarik Tunai).
        
        stdout.write('Jumlah yang ditarik : Rp');
          // stdout.write menampilkan teks tanpa pindah baris, jadi ketikan muncul di sampingnya.

        int? nominalTarik = int.tryParse(stdin.readLineSync()?.trim() ?? '');
          // Satu baris ini menjalankan 4 fungsi sekaligus, dari dalam ke luar:
          // 1. stdin.readLineSync() membaca ketikan pengguna. Hasilnya String? (bisa null).
          // 2. ?.trim() menghapus spasi di awal/akhir. Tanda ?. artinya trim() hanya dijalankan jika hasilnya tidak null.
          // 3. ?? '' artinya jika hasil sebelumnya null, pakai teks kosong '' sebagai gantinya.
          // 4. int.tryParse() mengubah teks menjadi angka. Jika gagal (huruf atau kosong), hasilnya null, bukan error.
          // Tipe int? artinya variabel ini boleh berisi angka atau null.

        if (nominalTarik == null || nominalTarik <= 0) {
          print('Nominal harus berupa angka positif.');
          continue;
        }
          // Validasi 1: tolak jika bukan angka (null), nol, atau negatif.
          // continue = lewati sisa kode di dalam while, lalu kembali ke awal perulangan (menu tampil lagi).
          // Berbeda dengan return yang mematikan seluruh program.

        if (nominalTarik % 50000 != 0) {
          print('Mohon masukkan nominal dalam kelipatan Rp50.000.');
          continue;
        }
          // Validasi 2: operator % menghitung sisa bagi. Jika sisa dibagi 50.000 bukan 0, berarti bukan kelipatan Rp50.000.
          // Contoh: 120.000 % 50.000 = 20.000 (ditolak), 150.000 % 50.000 = 0 (diterima).

        if (nominalTarik > saldo) {
          print('Saldo tidak cukup.');
          continue;
        }
          // Validasi 3: tolak jika nominal yang ditarik lebih besar dari saldo.

        print('1. Pecahan Rp50.000');
        print('2. Pecahan Rp100.000');
        stdout.write('Pilih Pecahan (1/2) : ');
          // Menampilkan pilihan pecahan uang yang diinginkan pengguna.

        int? pilihanPecahan = int.tryParse(stdin.readLineSync()?.trim() ?? '');
          // Sama seperti nominalTarik: baca ketikan, hapus spasi, ubah ke angka.
          // Jika bukan angka, hasilnya null, yang nanti ditangani oleh else.

        if (pilihanPecahan == 1) {
          print('Rp50.000 x ${nominalTarik ~/ 50000} lembar');
          saldo -= nominalTarik;
        }
          // Jika memilih pecahan 1:
          // ${...} adalah string interpolation untuk ekspresi (pakai kurung kurawal jika isinya perhitungan, bukan hanya nama variabel).
          // ~/ adalah pembagian bulat tanpa koma. Contoh: 250.000 ~/ 50.000 = 5 lembar.
          // saldo -= nominalTarik sama dengan saldo = saldo - nominalTarik (saldo dikurangi).

        else if (pilihanPecahan == 2) {
          print('Rp100.000 x ${nominalTarik ~/ 100000} lembar');
          if (nominalTarik % 100000 > 0) print('Rp50.000 x 1 lembar');
          saldo -= nominalTarik;
        }
          // Jika memilih pecahan 2:
          // Baris 1: ~/ 100.000 menghitung jumlah lembar Rp100.000. Contoh: 250.000 ~/ 100.000 = 2 lembar.
          // Baris 2: % 100.000 menghitung sisanya. Jika ada sisa (pasti Rp50.000 karena nominal kelipatan 50.000), tambah 1 lembar Rp50.000.
          // Baris 3: saldo dikurangi.

        else {
          print('Pilihan pecahan tidak valid.');
        }
          // Jika pilihan pecahan bukan 1 atau 2 (termasuk null/huruf), tampilkan pesan tidak valid.
          // Saldo tidak dikurangi karena baris saldo -= hanya ada di dalam if dan else if di atas.
      }
            // Kurung kurawal penutup: if menu 3, lalu while. Setelah itu program kembali ke atas (menampilkan menu lagi) selama ATM masih true.

      if (pilihMenu == '4') {
        print('Terima kasih telah menggunakan layanan kami.');
        ATM = false;
          // Jika memilih menu 4, tampilkan ucapan terima kasih dan ubah variabel ATM menjadi false sehingga perulangan while berhenti.
        }
      }
      // Kurung kurawal penutup: if menu 4.
}
