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
  if (password == null || password.trim().isEmpty) {
    print('Mohon masukkan PIN.');
    print('');
    return;
    }
      // Jika PIN null atau kosong (setelah spasi dihapus oleh trim()), tampilkan notifikasi lalu program berhenti dengan return.

    try {
      int passInt = int.parse(password.trim());
        // Command int.parse untuk mengubah teks PIN menjadi angka. Jika berisi huruf, akan error dan ditangkap oleh catch.

      if(passInt != 112233) {
        print('PIN salah.');
        print('');
        return;
      }
        // Jika PIN tidak sama dengan 112233, tampilkan "PIN salah" lalu program berhenti.

      print('');
      print('Selamat Datang');

      ATM = true;
        // Jika PIN benar, variabel ATM diubah menjadi true sehingga perulangan while di bawah bisa berjalan.

    } catch (e) {
      print('PIN harus berupa angka.');
    }
      // Blok catch menangkap error jika PIN yang diketik bukan angka. ATM tetap false sehingga menu tidak muncul.

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
        print('');
        stdout.writeln('Jumlah yang ditarik : Rp');
        var tarik = stdin.readLineSync();
          // Variabel stdin.readLineSync() untuk membaca nominal penarikan yang diketik.
          
        try {
          if (tarik == null || tarik.trim().isEmpty) {
            print('Mohon masukkan nominal.');
            return;
          }
            // Jika nominal null atau kosong, tampilkan notifikasi lalu program berhenti dengan return.

          int nominalTarik = int.parse(tarik.trim());
            // Mengubah teks nominal penarikan menjadi angka.

          if (nominalTarik % 50000 != 0) {
            print('Mohon masukkan nominal dalam kelipatan Rp50.000.');
            print('');
            return;
          }
            // Operator % (modulus) menghitung sisa bagi. Jika sisa bagi dengan 50.000 tidak sama dengan 0, berarti bukan kelipatan Rp50.000 sehingga penarikan ditolak.
          
          saldo = saldo - nominalTarik;
            // Saldo dikurangi sebesar nominal yang ditarik.
          print('=====================');
          print('Pilih Pecahan :');
          print('1. Pecahan Rp50.000');
          print('2. Pecahan Rp100.000');
          print('=====================');
          stdout.write('Pilih Pecahan (1/2) : ');
            // Command stdout.write sama seperti writeln, tetapi tanpa pindah baris sehingga ketikan muncul di samping teks.
          
          var pilihPecahan = stdin.readLineSync();
            // Variabel stdin.readLineSync() untuk membaca pilihan pecahan yang diketik.

          if(pilihPecahan == null || pilihPecahan.trim().isEmpty) {
            print('Pilihan pecahan tidak boleh kosong.');
            return;
          }
            // Jika pilihan pecahan null atau kosong, tampilkan notifikasi lalu program berhenti dengan return.

          int pilihanPecahan = int.parse(pilihPecahan.trim());
            // Mengubah teks pilihan pecahan menjadi angka agar bisa dibandingkan di if.
          print('=====================');
          print('Hasil Penarikan :');

          if (pilihanPecahan == 1) {
            var lembarPecahan50 = nominalTarik ~/ 50000;
            print('Rp50.000 x $lembarPecahan50 lembar');
          }
            // Jika memilih pecahan Rp50.000: operator ~/ (pembagian bulat) membagi nominal dengan 50.000 untuk mendapatkan jumlah lembar.
          else if (pilihanPecahan == 2) {
            var lembarPecahan100 = nominalTarik ~/ 100000;
            var sisa = nominalTarik % 100000;
              // lembarPecahan100 = jumlah lembar Rp100.000 (hasil bagi bulat). sisa = nominal yang tidak habis dibagi 100.000.

            print('Rp100.000 x $lembarPecahan100 lembar.');

            if (sisa > 0) {
              var lembarSisa50 = sisa ~/ 50000;
              print('Rp50.000 x $lembarSisa50 lembar.');
            }
              // Jika masih ada sisa (pasti Rp50.000 karena nominal kelipatan 50.000), sisa tersebut diberikan dalam 1 lembar Rp50.000.
          }
            // Jika memilih pecahan Rp100.000: uang dikeluarkan dalam lembar Rp100.000 dulu, sisanya dilengkapi Rp50.000.
          else {
            print('Pilihan pecahan tidak valid.');
          }
            // Jika pilihan pecahan selain 1 atau 2, tampilkan notifikasi tidak valid.
          } catch (e) {
            print('Nominal harus berupa angka');
          }
            // Blok catch menangkap error jika nominal atau pilihan pecahan yang diketik bukan angka.
        }
      }
        // Kurung kurawal penutup: if menu 3, lalu while. Setelah itu program kembali ke atas (menampilkan menu lagi) selama ATM masih true.
    }
