/*PRZYK£ADOWE ZAPYTANIA
Procedura DodajU¿ytkownika*/
--EXEC DodajU¿ytkownika @NazwaU¿ytkownika='User1',@ImiêU¿ytkownika='Basia', @NazwiskoU¿ytkownika='Kowalska', @NumerTelefonu='123456789'
--EXEC DodajU¿ytkownika @NazwaU¿ytkownika='User2',@ImiêU¿ytkownika='Janusz', @NazwiskoU¿ytkownika='Nowak', @NumerTelefonu='987654321'
--EXEC DodajU¿ytkownika @NazwaU¿ytkownika='User3',@ImiêU¿ytkownika='Katarzyna', @NazwiskoU¿ytkownika='Sowa', @NumerTelefonu='098765432'
--EXEC DodajU¿ytkownika @NazwaU¿ytkownika='User4',@ImiêU¿ytkownika='Bo¿ena', @NazwiskoU¿ytkownika='Wrona', @NumerTelefonu='234567890'

/*Wyzwalacz z³y numer*/
--EXEC DodajU¿ytkownika @NazwaU¿ytkownika='User5',@ImiêU¿ytkownika='Bo¿ena', @NazwiskoU¿ytkownika='Wrona', @NumerTelefonu='234'

/*Wyzwalacz powtarzaj¹ca siê nazwa u¿ytkownika*/
--EXEC DodajU¿ytkownika @NazwaU¿ytkownika='User4',@ImiêU¿ytkownika='Maciej', @NazwiskoU¿ytkownika='Wrona', @NumerTelefonu='234567890'

/*Procedura DodajZnajomego*/
--EXEC DodajZnajomego @NazwaU¿ytkownika1='User1', @NazwaU¿ytkownika2='User3'
--EXEC DodajZnajomego @NazwaU¿ytkownika1='User1', @NazwaU¿ytkownika2='User2'

/*Funkcja WyœwietlZnajomych*/
--SELECT * FROM WyœwietlZnajomych('User1')

/*Wyzwalacz nie wolno dodaæ tych samych znajomych*/
--EXEC DodajZnajomego @NazwaU¿ytkownika1='User1', @NazwaU¿ytkownika2='User2'

/* Procedura dodanie pomiaru*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=60, @ObwódPasa=70
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=62, @ObwódPasa=71

/*Fukcja wyœwietl pomiary u¿ytkownika*/
--SELECT * FROM WyœwietlPomiary('User1')

/*Wyzwalacz ujemny pomiar*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=62, @ObwódPasa=-71

/*Funkcja oblicz % tkanki t³uszczowej*/
--SELECT dbo.ObliczProcentTkankiT³uszczowej('User1')

/*Teraz wprowadzimy nowy pomiar, a kolejny raz % tkanki t³uszczowej obliczy siê dla nowo dodanego pomiaru*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=60, @ObwódPasa=70

/*Funkcja oblicz % tkanki t³uszczowej*/
--SELECT dbo.ObliczProcentTkankiT³uszczowej('User1')

/*widok Wyœwietlmy tagi sportowe*/
--SELECT * FROM WyœwietlTagiSportowe

/*widok Wyœwietl wszystkie treningi*/
--SELECT * FROM WyœwietlTreningi

/* widok Wyœwietl sk³ady treningów*/
--SELECT * FROM WyœwietlSk³adyTreningów

/*funkcja Wyœwietl trening po tagu*/
--SELECT * FROM WyœwietlTreningPoTagu('Cardio')

/*funkcja Wyœwietl æwiczenie po tagu*/
--SELECT * FROM WyœwietlÆwiczeniePoTagu('Brzuch')

/* funkcja wyswietl sk³ad wybranego treningu*/
--SELECT * FROM WyœwietlSk³adTreningu('Aerobik')

/* procedura zapisz trening*/
--EXEC ZapiszTrening @NazwaU¿ytkownika='User1', @NazwaTreningu='Aerobik'
--EXEC ZapiszTrening @NazwaU¿ytkownika='User1', @NazwaTreningu='Sztuki walki'

/*funkcja wyœwietl zapisane treningi*/
--SELECT * FROM WyœwietlZapisaneTreningi('User1')

/*wyzwalacz brak duplikatu zapisanego treningu*/
--EXEC ZapiszTrening @NazwaU¿ytkownika='User1', @NazwaTreningu='Sztuki walki'

/*procedura dodaj ocenê*/
--EXEC DodajOcenêTreningu @NazwaU¿ytkownika='User1', @NazwaTreningu='Aerobik', @Ocena=5

/*wyzwalacz ocena poza skal¹*/
--EXEC DodajOcenêTreningu @NazwaU¿ytkownika='User1', @NazwaTreningu='Sztuki walki', @Ocena=6

/*funkcja wyswietl ocenione*/
--SELECT * FROM WyœwietlOcenioneTreningi('User1')

/*wyzwalacz trening wczeœniej oceniony*/
--EXEC DodajOcenêTreningu @NazwaU¿ytkownika='User1', @NazwaTreningu='Aerobik', @Ocena=5

/*procedura zmieñ ocenê treningu*/
--EXEC ZmieñOcenêTreningu @NazwaU¿ytkownika='User1',@NazwaTreningu='Aerobik', @Ocena=3

/*trigger zmiana oceny poza skalê*/
--EXEC ZmieñOcenêTreningu @NazwaU¿ytkownika='User1',@NazwaTreningu='Aerobik', @Ocena=0

/*procedura Zaplanuj trening*/
--EXEC ZaplanujTrening @NazwaU¿ytkownika='User1', @NazwaTreningu='Sztuki walki', @DataRozpoczêcia='2021-01-21', @DataZakoñczenia='2021-01-26'
--EXEC ZaplanujTrening @NazwaU¿ytkownika='User1', @NazwaTreningu='Aerobik', @DataRozpoczêcia='2021-01-28', @DataZakoñczenia='2021-01-28'

/*wyzwalacz data rozpoczêcia póŸniejsza ni¿ data zakoñczenia*/
--EXEC ZaplanujTrening @NazwaU¿ytkownika='User1', @NazwaTreningu='Sztuki walki', @DataRozpoczêcia='2021-01-26', @DataZakoñczenia='2021-01-21'

/*funkcja Wyœwietl zaplanowane treningi u¿ytkownika*/
--SELECT * FROM WyœwietlZaplanowaneTreningi('User1')

/*funkcja wyswietl treningi na dzisiaj*/
--SELECT * FROM WyœwietlZaplanowaneTreningiNaDziœ('User1')

--------------------------------------------------------------------------------------------------------------------------




/*widok Wyœwietlmy tagi spo¿ywcze*/
--SELECT * FROM WyœwietlTagiSpo¿ywcze


/* widok Wyœwietl produkty*/
--SELECT * FROM WyœwietlProdukty

/*funkcja Wyœwietl produkty po tagu*/
--SELECT * FROM WyœwietlProduktPoTagu('wegetariañski')

 /*widok wyœwietl posi³ki*/
 --SELECT * FROM WyœwietlPosi³ki

/*funkcja Wyœwietl posi³ek po tagu*/
--SELECT * FROM WyœwietlPosi³ekPoTagu('wegañski')

/* funkcja wyswietl sk³ad wybranego posi³ku*/
--SELECT * FROM WyœwietlSk³adPosi³ku('Makaron z tofu, ciecierzyc¹ i szpinakiem')

/*widok Wyœwietl wszystkie Jad³ospisy*/
--SELECT * FROM WyœwietlJad³ospisy

/* widok Wyœwietl sk³ady jad³ospisów*/
--SELECT * FROM WyœwietlSk³adyJad³ospisów

/* funkcja wyswietl sk³ad wybranego jad³ospisu*/
--SELECT * FROM WyœwietlSk³adJad³ospisu('Zimowy jad³ospis wegetariañski')

/* procedura zapisz jad³ospis*/
--EXEC ZapiszJad³ospis @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegetariañski zawieraj¹cy ryby'
--EXEC ZapiszJad³ospis @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegañski'

/*funkcja wyœwietl zapisane jad³ospisy*/
--SELECT * FROM WyœwietlZapisaneJad³ospisy('User1')

/*wyzwalacz brak duplikatu zapisanego jad³ospisu*/
--EXEC ZapiszJad³ospis @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegañski'

/*procedura dodaj ocenê*/
--EXEC DodajOcenêJad³ospisu @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegetariañski zawieraj¹cy ryby', @Ocena=5

/*wyzwalacz ocena poza skal¹*/
--EXEC DodajOcenêJad³ospisu @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegañski', @Ocena=6

/*funkcja wyswietl ocenione*/
--SELECT * FROM WyœwietlOcenioneJad³ospisy('User1')

/*wyzwalacz jad³ospis wczeœniej oceniony*/
--EXEC DodajOcenêJad³ospisu @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegetariañski zawieraj¹cy ryby', @Ocena=5

/*procedura zmieñ ocenê jad³ospisu*/
--EXEC ZmieñOcenêJad³ospisu @NazwaU¿ytkownika='User1',@NazwaJad³ospisu='Jad³ospis wegetariañski zawieraj¹cy ryby', @Ocena=3

/*trigger zmiana oceny poza skalê*/
--EXEC ZmieñOcenêJad³ospisu @NazwaU¿ytkownika='User1',@NazwaJad³ospisu='Jad³ospis wegetariañski zawieraj¹cy ryby', @Ocena=0

/*procedura Zaplanuj jad³ospis*/
--EXEC ZaplanujJad³ospis @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegetariañski zawieraj¹cy ryby', @Data='2021-01-21'
--EXEC ZaplanujJad³ospis @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegañski', @Data='2021-01-26'

/*wyzwalacz juz jest zaplanowane na ten dzieñ*/
--EXEC ZaplanujJad³ospis @NazwaU¿ytkownika='User1', @NazwaJad³ospisu='Jad³ospis wegetariañski zawieraj¹cy ryby', @Data='2021-01-26'

/*funkcja Wyœwietl zaplanowane jad³ospisy u¿ytkownika*/
--SELECT * FROM WyœwietlZaplanowaneJad³ospisy('User1')

/*funkcja wyswietl jad³ospis na dzisiaj*/
--SELECT * FROM WyœwietlZaplanowaneJad³ospisyNaDziœ('User1')

/*procedura dodaj do listy zakupów*/
--EXEC DodajDoListyZakupów @NazwaProduktu='Bak³a¿an', @NazwaSklepu='Lidl', @NazwaU¿ytkownika='User1', @IloœæPorcji=1
--EXEC DodajDoListyZakupów @NazwaProduktu='Ciecierzyca', @NazwaSklepu='Biedronka', @NazwaU¿ytkownika='User1', @IloœæPorcji=2
--EXEC DodajDoListyZakupów @NazwaProduktu='Szpinak', @NazwaSklepu='Lidl', @NazwaU¿ytkownika='User1', @IloœæPorcji=1

/*funkcja wyœwietl listê zakupów*/

--SELECT * FROM WyœwietlListêZakupów('User1','Lidl')

/*procedura usuñ z listy*/
--EXEC UsuñZListyZakupów @NazwaProduktu='Bak³a¿an', @NazwaSklepu='Lidl', @NazwaU¿ytkownika='User1'

/*funkcja wyœwietl listê zakupów*/

--SELECT * FROM WyœwietlListêZakupów('User1','Lidl')