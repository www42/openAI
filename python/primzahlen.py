def ist_primzahl(zahl):
    if zahl <= 1:
        return False
    elif zahl <= 3:
        return True
    elif zahl % 2 == 0 or zahl % 3 == 0:
        return False
    i = 5
    while i * i <= zahl:
        if zahl % i == 0 or zahl % (i + 2) == 0:
            return False
        i += 6
    return True

def primzahlen_bis_100():
    primzahlen = []
    for num in range(2, 101):
        if ist_primzahl(num):
            primzahlen.append(num)
    return primzahlen

primzahlen = primzahlen_bis_100()
print("Primzahlen bis 100:", primzahlen)
