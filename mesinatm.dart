import 'dart:io';

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

var ATM = false;
int saldo = 2000000;

void main(){
  print('=====================');
  print('BANK SERBA ADA');
  print('=====================');
  stdout.writeln('Masukkan PIN Anda : ');
  var password = stdin.readLineSync();

  // ========= LOGIN ========= //
  if (password == null || password.trim().isEmpty) {
    print('Mohon masukkan PIN.');
    print('');
    return;
    }

    try {
      int passInt = int.parse(password.trim());

      if(passInt != 112233) {
        print('PIN salah.');
        print('');
        return;
      }

      print('');
      print('Selamat Datang');

      ATM = true;

    } catch (e) {
      print('PIN harus berupa angka.');
    }

    // ========= PROGRAM MESIN ATM ========= //
    while (ATM) {
      tampilMenu();
      stdout.writeln('Pilihan Menu (1/2/3) : ');
      var pilihMenu = stdin.readLineSync();
        
      if (pilihMenu == '1') {
        print('');
        print('=====================');
        print('SALDO SAAT INI : Rp$saldo');
      };

      if (pilihMenu == '2') {
        print('');
        stdout.writeln('Jumlah yang disetor : Rp');
        var setoran = stdin.readLineSync();

        if (setoran == null || setoran.trim().isEmpty) {
          print('Mohon masukkan nominal.');
          print('');
          return;
        }

        try {
          int jumlahSetoran = int.parse(setoran.trim());
          int hasilSaldo = saldo + jumlahSetoran;
          saldo = hasilSaldo;

          print('');
          print('Saldo sekarang : Rp$saldo');
        } catch (e) {
          print('Input tidak valid. Harap masukkan angka');
        }
      }

      if (pilihMenu == '3') {
        print('');
        stdout.writeln('Jumlah yang ditarik : Rp');
        var tarik = stdin.readLineSync();

        try {
          if (tarik == null || tarik.trim().isEmpty) {
            print('Mohon masukkan nominal.');
            return;
          }

          int nominalTarik = int.parse(tarik.trim());

          if (nominalTarik % 50000 != 0) {
            print('Mohon masukkan nominal dalam kelipatan Rp50.000.');
            print('');
            return;
          }
          
          saldo = saldo - nominalTarik;
          print('=====================');
          print('Pilih Pecahan :');
          print('1. Pecahan Rp50.000');
          print('2. Pecahan Rp100.000');
          print('=====================');
          stdout.write('Pilih Pecahan (1/2) : ');
          
          var pilihPecahan = stdin.readLineSync();

          if(pilihPecahan == null || pilihPecahan.trim().isEmpty) {
            print('Pilihan pecahan tidak boleh kosong.');
            return;
          }

          int pilihanPecahan = int.parse(pilihPecahan.trim());
          print('=====================');
          print('Hasil Penarikan :');

          if (pilihanPecahan == 1) {
            var lembarPecahan50 = nominalTarik ~/ 50000;
            print('Rp50.000 x $lembarPecahan50 lembar');
          } else if (pilihanPecahan == 2) {
            var lembarPecahan100 = nominalTarik ~/ 100000;
            var sisa = nominalTarik % 100000;

            print('Rp100.000 x $lembarPecahan100 lembar.');

            if (sisa > 0) {
              var lembarSisa50 = sisa ~/ 50000;
              print('Rp50.000 x $lembarSisa50 lembar.');
            }
          } else {
            print('Pilihan pecahan tidak valid.');
          }
          } catch (e) {
            print('Nominal harus berupa angka');
          }
        }
      }
    }
