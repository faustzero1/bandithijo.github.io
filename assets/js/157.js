function pass(url) {
    var kesempatan = 1;
    var kunci = prompt('Password : ','');

    while (kesempatan < 3) {
        if (!kunci)
            history.go(-1);

        if (kunci.toLowerCase() == "stmik") {
            alert('Selamat Datang, Bosku !');
            this.close();
            this.open(url);
            break;
        }

    kesempatan += 1;
    var kunci = prompt('Password Salah Ces !','');
    }

    if (kunci.toLowerCase() != "password" & kesempatan == 3)
        history.go(-1);

    return "";
}
