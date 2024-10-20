
-- 1 up

-- Create database
GRANT SELECT, INSERT, UPDATE ON barabend.* TO 'barabend'@'localhost';

-- Create tables

CREATE TABLE IF NOT EXISTS barabend.drinks (
    drink_id INT PRIMARY KEY AUTO_INCREMENT,
    drink_name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS barabend.bars (
    bar_id INT PRIMARY KEY AUTO_INCREMENT,
    bar_name VARCHAR(50),
    street VARCHAR(50),
    plz VARCHAR(5),
    city VARCHAR(25) DEFAULT 'Frankfurt am Main',
    description VARCHAR(1000),
    district VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS barabend.bars_drinks (
    bar_id INT,
    drink_id INT,
    PRIMARY KEY(bar_id, drink_id),
    FOREIGN KEY(bar_id) REFERENCES bars(bar_id) ON DELETE CASCADE,
    FOREIGN KEY(drink_id) REFERENCES drinks(drink_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS barabend.users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(20),
    password_hash VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS barabend.events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_date DATE,
    location INT,
    FOREIGN KEY(location) REFERENCES bars(bar_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS barabend.event_participants (
    event_id INT,
    user_id INT,
    PRIMARY KEY(event_id, user_id),
    FOREIGN KEY(event_id) REFERENCES events(event_id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS barabend.ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    rating_value INT,
    rating_comment VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS barabend.ratings_user_bars (
    rating_id INT,
    user_id INT,
    bar_id INT,
    PRIMARY KEY(rating_id, user_id, bar_id),
    FOREIGN KEY(rating_id) REFERENCES ratings(rating_id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY(bar_id) REFERENCES bars(bar_id) ON DELETE CASCADE
);

-- Add data for drinks table
INSERT INTO  barabend.drinks() VALUES(1, 'Bier');
INSERT INTO  barabend.drinks() VALUES(2, 'Wein');
INSERT INTO  barabend.drinks() VALUES(3, 'Cocktails');

-- Check table
SELECT * FROM barabend.bars_drinks;
SELECT * FROM barabend.drinks;
SELECT * FROM barabend.bars;

-- 1 down
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS barabend.bars;
DROP TABLE IF EXISTS barabend.bars_drinks;
DROP TABLE IF EXISTS barabend.drinks;
DROP TABLE IF EXISTS barabend.events;
DROP TABLE IF EXISTS barabend.event_participants;
DROP TABLE IF EXISTS barabend.ratings;
DROP TABLE IF EXISTS barabend.ratings_user_bars;
DROP TABLE IF EXISTS barabend.users;

SET FOREIGN_KEY_CHECKS = 1;
 
-- 2 up (...you can comment freely here...)
INSERT INTO barabend.bars() VALUES (1, 'BB Bar', 'Kaiserhofstr. 18', '60313', 'Frankfurt am Main', 'Frizz sagt: "Die besondere Bar im Bahnhofsviertel: Die B&amp;B Bar kommt im Leopardenfell-Look daher, Wirtin Biggi ist die Seele der Bar und zudem großer Eintracht-Fan. Und das merkt man! (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (2, '22nd Lounge &amp; Bar', 'Neue Mainzer Str. 66-68', '60311', 'Frankfurt am Main', 'Frizz sagt: "Die 22nd lounge&amp;bar ist Frankfurts Geheimtipp und bietet exklusive Atmosphäre bei Jazz, Live-Entertainment und DJs mit Blick auf Mainhattan. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (3, 'Autorenbar im Steigenberger Frankfurter Hof', 'Am Kaiserplatz', '60311', 'Frankfurt am Main', 'Frizz sagt: "Die Autorenbar ist wie ein guter Roman: eine ganz eigene Welt und unendlich zeitlos. Mittags kann man einen echten Royal High Tea und abends einen rauchigen Whisky oder exklusive Cocktail-Klassiker kosten. (www.frizz-frankfurt.de)"', 'Bahnhofsviertel');
INSERT INTO barabend.bars() VALUES (4, 'Demarchi Bar E Tabacchi', 'Walther-von-Cronberg-Platz 9', '60594', 'Frankfurt am Main', 'Frizz sagt: "Die Demarchi Bar E Tabacchi bildet zusammen mit A Casa di Tomilaia und Biancalani Cucina die Gastronomietrilogie und das Herzstück des Florentinischen Viertels. Am ersten Donnerstag im Monat werden hier After-Work-Partys veranstaltet. An den anderen Donnerstagen wird „Aperitivo Italiano" mit Fingerfood geboten. Freitags steht gelegentlich der „Salon Casanova" mit zwei DJs  auf dem Programm. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (5, 'Aber', 'Gutleutstr. 17', '60329', 'Frankfurt am Main', 'Frizz sagt: "Weder Bar noch Restaurant. Beim Betreten werden Fragen aufgeworfen, denn die kleinen Sitznischen laden zu einem intimen Abendessen ein, während die großen Fenster und hohen Decken gleichzeitig zu einem Bar-Abend mit Freundinnen und Freunden verlocken. Aber? Gerne. (www.frizz-frankfurt.de)"', 'Bahnhofsviertel');
INSERT INTO barabend.bars() VALUES (6, 'Barca', 'Südliches Mainufer unterhalb Deutschherrnufer', '60594', 'Frankfurt am Main', 'Frizz sagt: "Die „Barca" – eine mobile Cocktailbar in Form eines Segelbootes – sorgt für relaxte Stunden südlich des Mainufers. Die Gäste sitzen in Liegestühlen und genießen bei coolen Drinks und Lounge-Musik die Frankfurter Skyline. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (7, 'Amp', 'Gallusanlage 2', '60329', 'Frankfurt am Main', 'Frizz sagt: "Am Rande des Bahnhofviertels gelegen, präsentiert sich das Bar-Projekt von Ata Macias (Robert Johnson) als Treffpunkt für Menschen, die ein hochwertiges Angebot und ein kreatives Ambiente suchen. Herrliche Weine und Biere, sowohl klassische als auch selbst kreierte Drinks, die großzügige Terrasse mit Skylineblick und ein ausgesuchtes DJ-Line-up an ausgewählten Tagen. (www.frizz-frankfurt.de)"', 'Bahnhofsviertel');
INSERT INTO barabend.bars() VALUES (8, 'Coyote', 'Kleine Rittergasse 12', '60594', 'Frankfurt am Main', 'Frizz sagt: "Von tanzenden Coyotes auf der Bar über Feuer und Schlangenshows: Hier ist für jede und jeden etwas dabei. Immer außergewöhnlich. Dazu die besten Beats von verschiedenen namhaften DJs. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (9, 'FAB Frankfurt Art Bar', 'Ziegelhüttenweg 221', '60598', 'Frankfurt am Main', 'Frizz sagt: "Die Frankfurt Art Bar (FAB) verwöhnt ihre Gäste als Livemusik-Location mit Restaurant und Bar. Freitags Live-Jazz, an den anderen Abenden wechselndes Programm bei abwechslungsreicher Speisekarte mit frischen  hausgemachten Speisen. Großer sonniger Biergarten und  acht Sorten Schlappeseppel Biere. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (10, 'Bar Central', 'Elefantengasse 13', '60313', 'Frankfurt am Main', 'Frizz sagt: "Dass man sich auch als Hetero ganz wunderbar hierher verirren kann, beweist das Central ganz gut. Cocktails von versierten Barkeepern lassen das Szenelokal zu einem bevorzugten Treffpunkt für alle Nachtschwärmerinnen und -schwärmer werden. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (11, 'Jimmy\'s Bar', 'Friedrich-Ebert-Anlage 40', '60327', 'Frankfurt am Main', 'Frizz sagt: "Die Cocktailbar Jimmy\'s Bar im Grandhotel Hessischer Hof ist in mehr als 60 Jahren zu DER Bar in Frankfurt avanciert. Live-Pianomusik schätzen Liebhaber und Nachtschwärmer aus Frankfurt und aller Welt ebenso wie ihren Lieblingsdrink oder Cocktail in der Bar in gemütlichen Ledersesseln. (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (12, 'Stock Avenue 81 im Innside Frankfurt Ostend', 'Hanauer Landstr. 81', '60314', 'Frankfurt am Main', 'Frizz sagt: "Mit einer Mixtur aus trendigem Ambiente, Entertainment und Kommunikationszentrum kommt das Stock Avenue 81, eine hybride Mischung aus Restaurant, Hotelbar und Außenterrasse, daher. Die neue IN(N)-Location im Frankfurter Ostend! Urbanes Networking. Chillige Beats. Trendy Drinks. Food to share. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (13, 'Long Island Summer Lounge', 'Parkhaus Börse, Parkdeck 7/Kaiserstr. 12', '60313', 'Frankfurt am Main', 'Frizz sagt: "Wo kann man besser den Sommer zelebrieren als im Beachclub: Die Long Island Summer Lounge ist eine reine Sommer-Location, die von einem entspannten Partyvolk frequentiert wird. Der Sommer kann kommen! (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (14, 'wineLOUNGE', 'Meisengasse 9', '60313', 'Frankfurt am Main', 'Frizz sagt: "Gäste haben in der wineLOUNGE die Möglichkeit, 32 Weine by the glass zu probieren. Grand Crus, Große Gewächse und Raritäten, die es sonst nur flaschenweise gibt. Frankfurts neues Weinmekka! (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (15, 'TRARES Bar Restaurant', 'Luisenstr. 7', '60316', 'Frankfurt am Main', 'Frizz sagt: "Nicht nur Weinliebhaber kommen im TRARES auf ihre Kosten, auch Cocktailbegeisterte können sich stets von neuen Kreationen, aber auch von den bewährten Klassikern an der Bar begeistern lassen. (www.frizz-frankfurt.de)"', 'Nordend');
INSERT INTO barabend.bars() VALUES (16, 'Destino Tapas Bar', 'Habsburgerallee 9', '60385', 'Frankfurt am Main', 'Frizz sagt: "Das Destino versteht sich als Restaurant mit Cocktailbar und Loungekonzept. Große Fenster und eine vollflächige Spiegelwand lassen an ein Industrieloft denken, das an den Charme eines Kaminzimmers erinnert. Moderne Tapas-Interpretationen und das Lounge-Ambiente schaffen eine Wohlfühl-Atmosphäre. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (17, 'Bristol Bar', 'Ludwigstr. 15', '60327', 'Frankfurt am Main', 'Frizz sagt: "Hier wird geräuchert, gekocht, flambiert und experimentiert – kreative Drinks treffen auf kreative Leute und Frankfurter Locals. Mit regelmäßiger Livemusik, Kunstausstellungen und den legendären Ribs \'n\' Beer am Donnerstag ist die Bristol Bar ein zweites Wohnzimmer in der eigenen Stadt. (www.frizz-frankfurt.de)"', 'Gallus');
INSERT INTO barabend.bars() VALUES (18, 'Chinaski Tagesbar', 'Bockenheimer Landstr. 1', '60325', 'Frankfurt am Main', 'Frizz sagt: "Ein Treffpunkt für den geliebten Espresso vor der Arbeit, ein gesundes Frühstück zum Start in den Tag, ein Quick Lunch, eine Geschäftsbesprechung in lockerer Atmosphäre oder zum Aperitivo am frühen Abend. Ein charmantes Lokal für Menschen jeglicher Couleur mit einem Faible für Genuss, Qualität und Kultur. (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (19, 'Barhundert', 'Stiftstr. 34', '60313', 'Frankfurt am Main', 'Frizz sagt: "Tradition und Qualität – die Barhundert bereichert seit  sechs Jahren das Frankfurter Nachtleben mit ihrem einzigartigen Charme, regelmäßigen Events mit Livemusik und DJs, einer beeindruckenden Anzahl an Cocktails und dem immer noch spürbaren Flair von Rosemarie Nitribitt. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (20, 'McR&StM Frankfurt Pub', 'Hanauer Landstraße 99', '60314', 'Frankfurt am Main', 'Frizz sagt: "Mittlerweile einer festen Fangemeinde bekannt ist die einmalige Atmosphäre im McR&amp;StM Frankfurt Pub, der mit lecker Frankfurter Küche, Oysters &amp; Mussels und Livemusik-Sessions verwöhnt. Drinnen im roten Häuschen wie draußen im Biergarten. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (21, 'Life Style Bar im Maritim Hotel', 'Theodor-Heuss Allee 3', '60486', 'Frankfurt am Main', 'Frizz sagt: "Die Life Style Bar ist eine mehrfach ausgezeichnete Hotelbar mit Club- und Szenecharakter. Der Mix aus internationalen Business Travellern sowie lokalen Gästen gibt der Bar die ganz besondere Atmosphäre. Liveacts bieten täglich aktuelle Chart-Hits und viele andere Musikrichtungen. (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (22, 'Zenzakan', 'Taunusanlage 15', '60325', 'Frankfurt am Main', 'Frizz sagt: "Zwei erhabene Löwen flankieren den Eingang von Frankfurts exklusivem und einzigartigem Pan-Asian Supperclub, dem Zenzakan. Ein spektakuläres Konzept, kuschelige Nischen, kleine Séparées, ein raffiniertes Lichtkonzept, stimmungsvolle Musik und das außergewöhnliche Ambiente laden zum Essen, Trinken, Verweilen, Sehen und Gesehenwerden ein. (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (23, 'Belle Roofgarden', 'Hanauer Landstr. 190 190', '60314', 'Frankfurt am Main', 'Frizz sagt: "Die exklusivste Open-Air-Location des Belle Clubs, der Belle Roofgarden, befindet sich natürlich über den Dächern Frankfurts. Von Mai bis September kann man den Urlaub in der Stadt genießen und das immer freitags und samstags ab 20 Uhr. Ab 22 Uhr laden wechselnde DJs mit Tropical House zum Summer Clubbing ein. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (24, 'Maxie Eisen', 'Münchener Str. 18', '60329', 'Frankfurt am Main', 'Frizz sagt: "Maxie Eisen war ein Chicagoer Gangster, der in den 1920er-Jahren drei hebräische Fleisch-, Brot- und Fischhändlerverbände führte. Ganz in seinem Sinne steht diese Bar für hochwertige Küche, klassische Barkultur, ein stilvolles, durchdachtes Interieur und das Gefühl vergangener Zeiten. (www.frizz-frankfurt.de)"', 'Bahnhofsviertel');
INSERT INTO barabend.bars() VALUES (25, 'Gatsby Bar', 'Töngesgasse 7', '60311', 'Frankfurt am Main', 'Frizz sagt: "Eine Bar mit einem einmaligen Mix aus 20er-Jahre-Atmosphäre und modernen Elementen. Ein Hauch orientalischer Gemütlichkeit. So kann man das Gatsby beschreiben. Neben erlesenen Cocktails begeistert die große Gin-Auswahl. Am Wochenende sorgen DJs für Stimmung. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (26, 'Pracht', 'Niddastr. 54', '60329', 'Frankfurt am Main', 'Frizz sagt: "Hier wird alles geboten: von Electro und Deep House bis Soulbeats oder einfach ein gelassener Barabend. Die unkomplizierte Bar mit ihrem familiären Flair ist alles andere als alltäglich, hier trifft man sich zu guter Musik, leckerem Essen und hippen Getränken. Auch die Eventvielfalt wie Kinderdisco, Kochevents und Flohmarkt kann sich sehen lassen. (www.frizz-frankfurt.de)"', 'Gallus');
INSERT INTO barabend.bars() VALUES (27, 'Bonechina', 'Große Rittergasse 64', '60594', 'Frankfurt am Main', 'Frizz sagt: "Nachts im Frankfurter Stadtteil Alt-Sachsenhausen: In einem barocken Fachwerkhaus steht ein großer Elefant aus Porzellan, gefaltet wie eine Origamifigur. Er lädt ein, sich um ihn zu versammeln, die Geschichten der heiteren Gesellschaft aufzusaugen und die Bar-Inszenierung hochleben zu lassen. Ausgezeichnet mit dem FIZZZ Award für das innovativste Barkonzept 2017. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (28, 'Bar ohne Namen', 'Eschenheimer Tor 3', '60318', 'Frankfurt am Main', 'Frizz sagt: "Mattschwarze Wände, aus groben Holzplanken gezimmerte Sitzmöbel und verspielte Details wie Star-Wars- und Spiderman-Figuren findet man in der Bar ohne Namen. Neben den ausgefallenen Cocktails gibt es auch eine Auswahl an Speisen. Kein Wunder, dass die Bar zu den angesagtesten der Stadt zählt. „Good times for good people" lautet passenderweise das Motto. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (29, 'VAIVAI Italian Grill & Bar', 'Grüneburgweg 16', '60322', 'Frankfurt am Main', 'Frizz sagt: "Das VAIVAI begeistert durch die gelungene Kombination aus Food, Look & Feel. Mit feinsten House-Klängen verwöhnen die DJs am Freitag und am Samstag die Gäste. Außerdem gibt es leckere Speisen, old-fashioned und innovative Cocktailkreationen, bei schönem Wetter auch auf der Sommerterrasse. (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (30, 'Logenhaus', 'Finkenhofstr. 17', '60322', 'Frankfurt am Main', 'Frizz sagt: "In eine andere Welt eintreten? Das geht. Und zwar im Logenhaus, denn die Salonkultur der 20er- und 30er-Jahre soll hier wiederbelebt werden. Nächtlich, schillernd, anders. Gemeinsam mehr erleben. (www.frizz-frankfurt.de)"', 'Nordend');
INSERT INTO barabend.bars() VALUES (31, 'Sugar', 'Berger Str. 235', '60385', 'Frankfurt am Main', 'Frizz sagt: "Sowohl für Sommer wie auch für Winter geeignet. Denn im Sommer kann man im breiten Fensterrahmen gemütlich chillen und die Beine auf die Berger Straße baumeln lassen. Und im Winter kann man mit einem günstigen Espresso am knisternden Kamin sitzen. (www.frizz-frankfurt.de)"', 'Bornheim');
INSERT INTO barabend.bars() VALUES (32, 'Hunky Dory Bar', 'Baseler Str. 10', '60329', 'Frankfurt am Main', 'Frizz sagt: "Wer die Bar zum ersten Mal betritt, kann sich dem Nostalgie-Charme kaum entziehen. Sie ist im Stil der 30er Jahre mit Liebe zum Detail eingerichtet. Wo das Auge hinblickt: antike Telefone, mit denen man auf einen Drink einladen kann. Zum Interieur gehören außerdem ein einarmiger Bandit, Vintage-Tischkicker und besondere Gläser aus der Art déco-Zeit, aus denen die Gäste speziell kreierte Cocktails genießen. (www.frizz-frankfurt.de)"', 'Gutleutviertel');
INSERT INTO barabend.bars() VALUES (33, 'Old Fashioned Bar', 'Klappergasse 35-39', '60594', 'Frankfurt am Main', 'Frizz sagt: "Die Old Fashioned Bar in Frankfurt-Sachsenhausen bietet besten Jazz, Soul, Funk, House und Electroswing. Es darf getanzt werden. Aber auch ruhige Barabende mit klassischen oder kreativeren Cocktails oder dem namensgebenden Getränk Old Fashioned (Whisky-Cocktail mit Bourbon) kann man hier genießen. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (34, 'Pik Dame', 'Elbestr. 31', '60329', 'Frankfurt am Main', 'Frizz sagt: "Ein gutes Programm in einer einzigartigen Atmosphäre. Rote Plüschsessel, Tischchen mit kleinen Lampen und Karussellpferde an der Bar sorgen für das nötige Kiez-Ambiente in Frankfurts ältestem Cabaret. Kabarett, Livemusik, Zauberei und natürlich ein bisschen Haut gibt es an jedem letzten Sonntag im Monat. (www.frizz-frankfurt.de)"', 'Bahnhofsviertel');
INSERT INTO barabend.bars() VALUES (35, 'JFK Bar in der Villa Kennedy', 'Kennedyallee 70', '60596', 'Frankfurt am Main', 'Frizz sagt: "Stylishes Interieur und kreative Drinks machen die JFK Bar zum place to be, beliebt bei Hotelgästen und Frankfurtern zugleich. Passionierte Bartender begleiten die Gäste durch ein Menü aus 120 spannenden Cocktails, Klassikern, edlen Weinen und einer Auswahl an Snacks. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (36, 'Chinaski No Bar: No Disco', 'Bockenheimer Landstr. 1', '60325', 'Frankfurt am Main', 'Frizz sagt: "Exzellente Cocktails, perfekte Drinks und coole Musik, aufgelegt von angesagten DJs der Stadt. Ein Ort für Persönlichkeiten, die Genuss in vollen Zügen zelebrieren. Das Chinaski-Barteam arbeitet qualitätsbewusst, detailverliebt und ausschließlich mit frischen, hochwertigen Zutaten. (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (37, 'T&T Bar', 'Mörfelder Landstr. 235', '60598', 'Frankfurt am Main', 'Frizz sagt: "Das Thai & Turf ist wohlbekannt für seine Premiumsteaks und Burger. Mit der Nightdining T&T Bar kann hier nun auch exklusives Bar-Ambiente in chilliger Atmosphäre genossen werden. Ledersofas, Classic- und Signaturedrinks sowie weit über 250 Spirituosen zu Premiumsteaks und Burgern sorgen bis 3 Uhr für eine perfekte Nacht. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (38, 'The Legacy', 'Wiesenhüttenplatz 28-38', '60329', 'Frankfurt am Main', 'Frizz sagt: "The Legacy Bar & Grill ist der neue Hotspot für Kosmopoliten im Bahnhofsviertel. Hier servieren Küchenchef Sven Frambach und Gastgeber Javier Villacampa mit ihren Teams Barbecue- und Smoked-Spezialitäten. In der Bar des The Legacy kreieren die Barkeeper Smokey-Cocktails, Cocktail-Klassiker, Signature Drinks und Mixologist-Kreationen. (www.frizz-frankfurt.de)"', 'Gutleutviertel');
INSERT INTO barabend.bars() VALUES (39, 'Luna Bar', 'Stiftstr. 6', '60313', 'Frankfurt am Main', 'Frizz sagt: "Die Luna Bar punktet mit perfekten Cocktails, feinsten Zigarren und professionellen Barkeepern. Höhepunkte und Abwechslung bieten monatliche Events wie Cocktailschulungen sowie Gin- und Whiskytastings. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (40, 'Sub Rosa Bar', 'Gaußstraße 4', '60316', 'Frankfurt am Main', 'Frizz sagt: "Das Sub Rosa ist weit mehr als eine Bar, versteht sich als kulturelle Plattform. Für 2018 sind Ausstellungen, Lesungen und wechsende DJs geplant und einmal im Monat ist ein Kinoabend angedacht. Zudem werden in der charmanten Nordend-Bar regelmäßig Weinseminare angeboten. Die große Bandbreite an Spirituosen lässt keine Wünsche offen, Cocktails werden individuell zubereitet. (www.frizz-frankfurt.de)"', 'Nordend');
INSERT INTO barabend.bars() VALUES (41, 'Champions Sports Bar', 'Hamburger Allee 2', '60486', 'Frankfurt am Main', 'Frizz sagt: "Hier trifft sich, wer nette Gesellschaft mag. Ein Ort für Sportfreundinnen und -freunde, die dem Sieg gemeinsam auf 18 HD-Monitoren und fünf HD-Großleinwänden entgegenfiebern oder sich auf ein entspanntes Bier nach Feierabend treffen – Champions  – The American Sportsbar & Restaurant – unkompliziert und einzigartig. (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (42, 'Fleming\'s Club Bar', 'Eschenheimer Tor 2', '60318', 'Frankfurt am Main', 'Frizz sagt: "Mit dem historischen Paternoster geht es hinauf in das Fleming\'s Club Restaurant und Bar. Bei klassischen und trendigen Cocktail-Spezialitäten oder einem der zahlreichen Spitzenweine genießt man die Aussicht über die Frankfurter Skyline. Im Sommer lockt die große Rooftop-Terrasse, um den Abend bei einem Sundowner ausklingen zu lassen. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (43, 'Blaues Wasser', 'Franziusstr. 35', '60314', 'Frankfurt am Main', 'Frizz sagt: "Das Blaue Wasser ist ein Open-Air-Restaurant mit Event-Möglichkeiten direkt am Mainufer. Im überdachten und regensicheren Außenbereich befindet sich das Restaurant. Neben der berühmten roten Wandelbar werden auch kühle Drinks an der Riverbar direkt am Fluss serviert. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (44, 'Drinksmith Bar', 'Wallstr. 14', '60594', 'Frankfurt am Main', 'Frizz sagt: "Die Drinksmith Bar in Sachsenhausen darf wohl als klassische Bar betitelt werden, die alles das hat, was Barliebhaber suchen: Edle Biere von kleinen privaten Brauereien, eine feine Auswahl an Spirituosen, klassische, zeitlose Cocktails und eigene Kreationen. Für Kaffeeliebhaber auch gerne einen Espresso. Ein angenehmes und einladendes Ambiente rundet das Barkonzept ab. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (45, 'Sandbar', 'Sandweg 6', '60316', 'Frankfurt am Main', 'Frizz sagt: "Schummriges Licht und gedeckte Farben sorgen für eine angenehme, entspannte Atmosphäre beim Cocktailgenuss und bei klassischen Longdrinks. Eine Institution in Frankfurts Osten und seit über 15 Jahren immer wieder einen Besuch wert. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (46, 'Roomers Bar', 'Gutleutstr. 85', '60329', 'Frankfurt am Main', 'Frizz sagt: "Im Roomers ist alles vom Feinsten, das Interieur stylish, die Drinks ausgezeichnet. Hier treffen sich Genießer, Szenegänger und internationales Publikum in entspannter Atmosphäre. Zuletzt wurde die Bar mit dem heiß begehrten Mixology Award zur „Hotelbar des Jahres 2016" ausgezeichnet. (www.frizz-frankfurt.de)"', 'Gutleutviertel');
INSERT INTO barabend.bars() VALUES (47, 'Ember Bar & Lounge im Jumeirah Frankfurt', 'Thurn-und-Taxis Platz 2', '60313', 'Frankfurt am Main', 'Frizz sagt: "Die Ember Bar & Lounge ist tagsüber ein entspannter Ort, um vor der Kulisse des Palais einen Snack oder Kaffee zu sich zu nehmen. Bei beschwingtem Ambiente gibt es abends exquisite Getränke und als Highlight begeistert  Mr. Soul Derrick Smith jeden Mittwoch ab 21 Uhr mit seiner Livemusik. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (48, 'Die Rote Bar', 'Mainkai 7', '60311', 'Frankfurt am Main', 'Frizz sagt: "Schummriges Ambiente, düstere Atmosphäre, coole Barkeeper – die am Mainufer gelegene Bar ist Kult und die Whisky-Karte lässt Herzen höher schlagen. Hier trifft sich entspanntes Volk zum ebensolchen Barabend. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (49, 'Harry\'s New York Bar', 'Walther-von-Cronberg-Platz 1', '60594', 'Frankfurt am Main', 'Frizz sagt: "Renommierter Treffpunkt in traditionellem Club-Ambiente mit Live-Piano und ausgezeichneten Drinks und Cocktails. Die Harry\'s New York Bar ist wohl eine der besten Locations für Zigarren- und Whisky-Aficionados in Frankfurt. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (50, 'Oosten Realwirtschaft', 'Mayfarthstr. 4', '60314', 'Frankfurt am Main', 'Frizz sagt: "Im Oosten, transparent aus Glas, Stahl, Sichtbeton und Holz gebaut, sitzt man immer auf der Sonnenseite. Hier kann man spektakuläre 270-Grad-Perspektiven auf die Frankfurter Skyline und die gläserne Fassade der EZB genießen, genauso wie die erlesene Getränkeauswahl und das vorzügliche Speisenangebot. Ab und an stehen feinste Partys auf dem Programm. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (51, 'EAST GRAPE', 'Louis-Appia-Passage 12', '60314', 'Frankfurt am Main', 'Frizz sagt: "Wiederbelebung der klassischen Barkultur wird hier groß geschrieben – ein Ort für Genussmenschen, die besonders deutsche Weine schätzen. Mit guter Musik und einem unglaublichen Ambiente lässt sich im East Grape der eine oder andere gelungene Abend verbringen. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (52, 'Lili\'s Bar im Sofitel Frankfurt Opera', 'Opernplatz 16', '60313', 'Frankfurt am Main', 'Frizz sagt: "Zusätzlich zum klassischen Angebot einer Hotelbar mit Champagnercocktails und Klassikern wie Manhattan oder Negroni setzt Barchef Ran Hoch auf eigene Kreationen wie hausgemachte Infusionen. Regelmäßige Tastings, Konzerte und Events. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (53, 'Rot & Vogel', 'Rotlintstr. 28', '60318', 'Frankfurt am Main', 'Frizz sagt: "Wohnzimmer-Flair im Nordend. Gute Drinks. Für gute Leute. Für das Nordend. Für Frankfurt. Was will man mehr?! (www.frizz-frankfurt.de)"', 'Nordend');
INSERT INTO barabend.bars() VALUES (54, 'Mosaik Jazz Bar', 'Freiligrathstr. 57', '60313', 'Frankfurt am Main', 'Frizz sagt: "Junge Künstler, Solisten und Duos bis zum Quintett, alle können sich hier auf der Bühne austoben. Eine große Auswahl an Getränken rundet das Ganze noch ab. Nicht nur für Jazzliebhaber ein Garant für einen perfekten Abend. (www.frizz-frankfurt.de)"', 'Bornheim');
INSERT INTO barabend.bars() VALUES (55, 'Jambo Bar', 'Elbestr. 20', '60327', 'Frankfurt am Main', 'Frizz sagt: "Gin-Liebhaber sind hier gern gesehen. Denn in der nicht ganz gewöhnlichen Bar findet man über 60 Sorten Gin. Für den kleinen Hunger gibt es kenianische Swahili-Spezialitäten. (www.frizz-frankfurt.de)"', 'Bahnhofsviertel');
INSERT INTO barabend.bars() VALUES (56, 'Copper Bar Room', 'An der Welle', '60322', 'Frankfurt am Main', 'Frizz sagt: "Direkt an der Alten Oper kann man sich hier auf zwei Stockwerken nach der Arbeit verwöhnen lassen. Großzügige Bar und kommunikativer Sitzbereich. Leckere Speisen und außergewöhnliche Getränke. Auch die regelmäßig stattfindenden Tastings sind ein Muss sowie die Thir(s)ty Partys, die einmal im Monat hier stattfinden. (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (57, 'Pearly Gates', 'Kleine Hochstr. 20', '60313', 'Frankfurt am Main', 'Frizz sagt: "Der ZZ TOP-Gitarrist Billy Gibbons spielt am liebsten auf seiner Lieblingsgitarre, die er Pearly Gates nennt. Und so heißt auch die Bar des GIBSON Club. Inspiriert von den 20er-Jahren, wurde hier eine Bar kreiert, die vom spannenden Mix aus Alt und Neu lebt. Anspruchsvolle Bar-Gänger schätzen das außergewöhnliche Cocktail-Angebot mit frischen Zutaten sowie die große Auswahl an Spirituosen und Weinen. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (58, 'Das Nord', 'Sandweg 64', '60316', 'Frankfurt am Main', 'Frizz sagt: "Kuschelrock und Astrapunsch! Ein Abend auf dem Kiez könnte nicht besser beginnen … oder enden. Nordisches Bier, nordisches Fachsimpeln am Tresen. In rauchiger Atmosphäre und mit Liebe zum Detail ist von einem gemütlichen Barabend bis zum wilden Treiben alles möglich. (www.frizz-frankfurt.de)"', 'Nordend');
INSERT INTO barabend.bars() VALUES (59, 'ONYX Bar in der Kameha Suite', 'Taunusanlage 20', '60325', 'Frankfurt am Main', 'Frizz sagt: "Stylisches Ambiente, fancy Drinks und eine einzigartige Auswahl an Gins! Bei Loungemusik und DJs an ausgewählten Samstagen treffen sich hier Genießer, Nachtschwärmer und Barliebhaber. Im Sommer ist die Terrasse im Grünen ein echter Insidertipp! (www.frizz-frankfurt.de)"', 'Westend');
INSERT INTO barabend.bars() VALUES (60, 'The Parlour', 'Zwingergasse 6', '60313', 'Frankfurt am Main', 'Frizz sagt: "Bars, die durch die Lage oder das Publikum auffallen, sind Geschichte. Die Qualität der Getränke steht im The Parlour im Vordergrund: Eine der besten Bars für Cocktail-Fans in Frankfurt und ein Szenetreff mit barriereloser Gastfreundschaft und mit gemütlich-vertrautem Flair. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (61, 'The Kinly Bar', 'Elbestr. 34', '60327', 'Frankfurt am Main', 'Frizz sagt: "Das Bahnhofsviertel wird immer mehr zum It-Viertel für Frankfurt. Feine Cocktails können in der Kinly Bar getrunken werden. Schlicht im Stil der 20er- und 30er-Jahre eingerichtet, legt man hier besonders Wert auf Handwerk und Qualität: handgeschlagenes, klares Eis, hausgemachte Tonics und eine großartige Spirituosenauswahl sind nur einige der Höhepunkte. Einen Besuch auf jeden Fall wert. (www.frizz-frankfurt.de)"', 'Bahnhofsviertel');
INSERT INTO barabend.bars() VALUES (62, 'Moloko+', 'Kurt-Schumacher-Str. 1', '60313', 'Frankfurt am Main', 'Frizz sagt: "Moloko am Meer nennt sich die Szenebar im Retroambiente in schicker Mainlage. Erwachseneres, trendiges Publikum kommt zum Entspannen dorthin. Freundinnen und Freunde trifft man im Moloko sicherlich auch. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (63, 'Oost Bar im 25hours Hotel The Goldman', 'Hanauer Landstr. 127-129', '60314', 'Frankfurt am Main', 'Frizz sagt: "Individuell gemixte Cocktails, ausgefallene Weine und nicht zuletzt ausgewählte Musik zeichnen das Bild der Oost Bar. Events mit jungen Künstlern sorgen für eine außergewöhnliche Atmosphäre. Balsam für die Sinne. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (64, 'Feinstaub', 'Friedberger Landstr. 131', '60318', 'Frankfurt am Main', 'Frizz sagt: "Die Musikbar im Norden mit täglich wechselnden DJs und einem schönen Garten im Hinterhof. Auch auf dem Museumsuferfest ist das Feinstaub mit zwei Bühnen vertreten und bietet mit dem Tiefgrund ein paar Meter weiter eine clubbige Alternative, die auch gemietet werden kann. (www.frizz-frankfurt.de)"', 'Nordend');
INSERT INTO barabend.bars() VALUES (65, 'Schwedler See', 'Schwedlerweg', '60323', 'Frankfurt am Main', 'Frizz sagt: "Eine chillige Bar am Schwedler See. Mehr braucht man nicht. In einer der verstecktesten Lagen von Frankfurt, nämlich am Ende des Osthafenbeckens beim Ersten Frankfurter Schwimmclub liegt das Kleidod zum Relaxen vom hektischen Frankfurter Leben. (www.frizz-frankfurt.de)"', 'Ostend');
INSERT INTO barabend.bars() VALUES (66, 'Good Fellas', 'Textorstr. 74', '60594', 'Frankfurt am Main', 'Frizz sagt: "Good Fellas bedeutet soviel wie gute Jungs. Industrie-Chic mit Lagerhausdesign: Europaletten, Stühle an Ketten. Internationale Speisen bis Mitternacht und eine herzliche Atmosphäre sorgen für einen perfekten Abend. New Fellas are in Town! (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (67, 'Hopper\'s Cocktailbar', 'Schneckenhofstr. 8', '60596', 'Frankfurt am Main', 'Frizz sagt: "Fans der Bar- und Trinkkultur vom 19. bis zum 21. Jahrhundert sind hier an der richtigen Stelle. Das Hopper\'s ist eine kleine Neighborhood-Bar mit schöner heimeliger Atmosphäre. (www.frizz-frankfurt.de)"', 'Sachsenhausen');
INSERT INTO barabend.bars() VALUES (68, 'VistaBar & Lounge Hilton Frankfurt City Centre', 'Hochstr. 4', '60313', 'Frankfurt am Main', 'Frizz sagt: "Modernes, geradliniges Design mit absolutem Wohlfühlfaktor. Gin-Liebhaber kommen auf ihre Kosten, zudem besticht das ausgesuchte Spirituosensortiment. Speisen: regionale Klassiker und internationale Highlights. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (69, 'Sullivan', 'Kaiserstr. 12', '60311', 'Frankfurt am Main', 'Frizz sagt: "GESCHMACK IST FORMSACHE! Wer Barkeeper-Kultur und außergewöhnliche Geschmacksrichtungen erleben möchte, ist im Sullivan am richtigen Ort. Auf zwei Etagen mit Billardtisch und kleinen Sitznischen bietet die Bar den Gästen eine schicke Wohlfühlatmosphäre. Musikalisch sorgen DJs für gute Stimmung. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (70, 'Gekkos', 'Hochstr. 4', '60313', 'Frankfurt am Main', 'Frizz sagt: "Klassische Drinks und Eigenkreationen des mehrfach ausgezeichneten Barteams, große Auswahl an feinen Spirituosen und Champagner sowie ein gut sortierter Humidor mit feinster Zigarrenauswahl: Das Gekkos ist die Location für Kenner. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (71, 'Wunderbar', 'Antoniterstr. 16', '65929', 'Frankfurt am Main', 'Frizz sagt: "Nicht nur Bar oder Restaurant, sondern ein toller Treffpunkt für alle, die ein bisschen Gastro-Kultur erleben wollen. Bereits seit 30 Jahren ist die Wunderbar direkt neben dem Neuen Theater Höchst zu finden, wo nicht nur Gäste aus Höchst zu Besuch sind. (www.frizz-frankfurt.de)"', 'Hochst');
INSERT INTO barabend.bars() VALUES (72, 'Lucille', 'Friedberger Landstr. 100', '60316', 'Frankfurt am Main', 'Frizz sagt: "Jeden Donnerstag und Freitag verwandelt sich das Kaffeehaus Lucille in eine Bar, in der neben tollen Drinks auch lecker gekocht wird. Hier gibt es nur sorgfältig ausgewählte Zutaten, sowohl hinter dem Tresen als auch in der Küche. Für die musikalische Laune der Gäste sorgt Memphis Records mit Musik von den Plattentellern. (www.frizz-frankfurt.de)"', 'Nordend');
INSERT INTO barabend.bars() VALUES (73, 'Seven Swans & The Tiny Cup', 'Mainkai 4', '60311', 'Frankfurt am Main', 'Frizz sagt: "Ein Entschleunigungsheim auf 17 Quadratmetern! Das Seven Swans & The Tiny Cup ist Frankfurts kleinste Bar im schmalsten Haus der Stadt. In einem hochmodernen Look, der trotz seiner nur 4,5 mal  3,8 Meter Grundfläche erstaunlich luftig wirkt, werden sich Freunde gepflegter Trinkkultur bei neuen kreativen Drinks und alten Klassikern wie zu Hause fühlen. (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (74, 'Mantis Roofgarden', 'Katharinenpforte 6', '60311', 'Frankfurt am Main', 'Frizz sagt: "Exklusives Design, edle Ausstattung und eine atemberaubende Dachterrasse. Feiern in einer einzigartigen Atmosphäre, die ihresgleichen sucht. Ein gern besuchter Hot Spot … (www.frizz-frankfurt.de)"', 'Innenstadt');
INSERT INTO barabend.bars() VALUES (75, 'Antony\'s', 'Berger Str. 14', '60316', 'Frankfurt am Main', 'Frizz sagt: "Das Antony\'s ist eine Classic Bar und eine kleine Oase für die Freunde der gepflegten Trinkkultur. Exklusive Auswahl an Cocktails und feinsten Spirituosen (täglich Happy Hour 19-21 Uhr). Regionale Produkte wie Cocktails und für den kleinen Hunger die feine Frankfurter Rindswurst. (www.frizz-frankfurt.de)"', 'Nordend');
INSERT INTO barabend.bars_drinks() VALUES (7, 1);
INSERT INTO barabend.bars_drinks() VALUES (7, 2);
INSERT INTO barabend.bars_drinks() VALUES (9, 1);
INSERT INTO barabend.bars_drinks() VALUES (10, 3);
INSERT INTO barabend.bars_drinks() VALUES (14, 1);
INSERT INTO barabend.bars_drinks() VALUES (14, 2);
INSERT INTO barabend.bars_drinks() VALUES (15, 2);
INSERT INTO barabend.bars_drinks() VALUES (17, 1);
INSERT INTO barabend.bars_drinks() VALUES (19, 3);
INSERT INTO barabend.bars_drinks() VALUES (20, 1);
INSERT INTO barabend.bars_drinks() VALUES (25, 3);
INSERT INTO barabend.bars_drinks() VALUES (28, 3);
INSERT INTO barabend.bars_drinks() VALUES (32, 3);
INSERT INTO barabend.bars_drinks() VALUES (33, 3);
INSERT INTO barabend.bars_drinks() VALUES (35, 2);
INSERT INTO barabend.bars_drinks() VALUES (35, 3);
INSERT INTO barabend.bars_drinks() VALUES (36, 3);
INSERT INTO barabend.bars_drinks() VALUES (38, 3);
INSERT INTO barabend.bars_drinks() VALUES (39, 3);
INSERT INTO barabend.bars_drinks() VALUES (40, 2);
INSERT INTO barabend.bars_drinks() VALUES (40, 3);
INSERT INTO barabend.bars_drinks() VALUES (41, 1);
INSERT INTO barabend.bars_drinks() VALUES (42, 2);
INSERT INTO barabend.bars_drinks() VALUES (44, 1);
INSERT INTO barabend.bars_drinks() VALUES (44, 3);
INSERT INTO barabend.bars_drinks() VALUES (49, 3);
INSERT INTO barabend.bars_drinks() VALUES (51, 2);
INSERT INTO barabend.bars_drinks() VALUES (52, 3);
INSERT INTO barabend.bars_drinks() VALUES (57, 2);
INSERT INTO barabend.bars_drinks() VALUES (58, 1);
INSERT INTO barabend.bars_drinks() VALUES (61, 3);
INSERT INTO barabend.bars_drinks() VALUES (63, 2);
INSERT INTO barabend.bars_drinks() VALUES (63, 3);
INSERT INTO barabend.bars_drinks() VALUES (75, 3);

-- 2 down
DELETE FROM barabend.bars_drinks WHERE 1=1;
DELETE FROM barabend.bars WHERE 1=1;

-- 3 up
CREATE TABLE barabend.roles(  
    role_id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique role id',
    role_name VARCHAR(50) COMMENT 'Name of the role',
    role_description VARCHAR (255) COMMENT 'Describe the group'
) DEFAULT CHARSET UTF8 COMMENT '';

-- 3 down
DROP Table barabend.roles;

-- 4 up
INSERT INTO barabend.roles(role_id,role_name,role_description) VALUES(1,'admin','Unrestricted Access');
INSERT INTO barabend.roles(role_id,role_name,role_description) VALUES(2,'editor','Can create update and delete bars');
INSERT INTO barabend.roles(role_id,role_name,role_description) VALUES(3,'user','Can read bars and update own stores');
ALTER TABLE barabend.users ADD COLUMN salt char(50) NOT NULL comment 'To salt hash';
ALTER TABLE barabend.users ADD COLUMN role int NOT NULL DEFAULT 3 comment 'Speicify the role of the user (1:1 Relationship)';
ALTER TABLE barabend.users ADD CONSTRAINT FOREIGN KEY fk_users_role (role) REFERENCES barabend.roles(role_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE barabend.users ADD UNIQUE unique_user_name (user_name);
ALTER TABLE barabend.roles ADD UNIQUE unique_role_name (role_name);

-- 4 down
DELETE FROM barabend.roles WHERE 1=1;
ALTER TABLE barabend.users DROP COLUMN salt;
ALTER TABLE barabend.users DROP CONSTRAINT fk_users_role;
ALTER TABLE barabend.users DROP COLUMN role;
DROP INDEX unique_user_name ON barabend.users;
DROP INDEX unique_role_name ON barabend.roles;

-- 5 up
GRANT DELETE ON barabend.* TO 'barabend'@'localhost';

-- 5 down
REVOKE DELETE ON barabend.* FROM 'barabend'@'localhost';

-- 6 up
UPDATE bars SET bar_name='22nd Lounge & Bar' WHERE bar_id=2;

-- 6 down
UPDATE bars SET bar_name='22nd Lounge & Bar' WHERE bar_id=2;

-- 7 up
DROP TABLE IF EXISTS barabend.bars_drinks;
UPDATE barabend.drinks SET drink_name='Beer' WHERE drink_id=1;
UPDATE barabend.drinks SET drink_name='Wine' WHERE drink_id=2;
INSERT INTO  barabend.drinks(drink_id, drink_name) VALUES(4, 'Gin');
INSERT INTO  barabend.drinks(drink_id, drink_name) VALUES(5, 'Whisky');
ALTER TABLE barabend.bars ADD COLUMN drinks SET('Beer','Wine','Cocktails','Gin','Whisky') comment 'What drinks is the bar famous for';
UPDATE barabend.bars SET drinks='Beer,Wine' WHERE bar_id=7;
UPDATE barabend.bars SET drinks='Beer' WHERE bar_id=9;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=10;
UPDATE barabend.bars SET drinks='Beer,Wine' WHERE bar_id=14;
UPDATE barabend.bars SET drinks='Wine' WHERE bar_id=15;
UPDATE barabend.bars SET drinks='Beer' WHERE bar_id=17;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=19;
UPDATE barabend.bars SET drinks='Beer' WHERE bar_id=20;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=25;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=28;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=32;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=33;
UPDATE barabend.bars SET drinks='Wine,Cocktails' WHERE bar_id=35;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=36;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=38;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=39;
UPDATE barabend.bars SET drinks='Wine,Cocktails' WHERE bar_id=40;
UPDATE barabend.bars SET drinks='Beer' WHERE bar_id=41;
UPDATE barabend.bars SET drinks='Wine' WHERE bar_id=42;
UPDATE barabend.bars SET drinks='Beer,Cocktails' WHERE bar_id=44;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=49;
UPDATE barabend.bars SET drinks='Wine' WHERE bar_id=51;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=52;
UPDATE barabend.bars SET drinks='Wine' WHERE bar_id=57;
UPDATE barabend.bars SET drinks='Beer' WHERE bar_id=58;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=61;
UPDATE barabend.bars SET drinks='Wine,Cocktails' WHERE bar_id=63;
UPDATE barabend.bars SET drinks='Cocktails' WHERE bar_id=75;

-- 7 down
CREATE TABLE IF NOT EXISTS barabend.bars_drinks (
    bar_id INT,
    drink_id INT,
    PRIMARY KEY(bar_id, drink_id),
    FOREIGN KEY(bar_id) REFERENCES bars(bar_id) ON DELETE CASCADE,
    FOREIGN KEY(drink_id) REFERENCES drinks(drink_id) ON DELETE CASCADE
);
INSERT INTO barabend.bars_drinks() VALUES (7, 1);
INSERT INTO barabend.bars_drinks() VALUES (7, 2);
INSERT INTO barabend.bars_drinks() VALUES (9, 1);
INSERT INTO barabend.bars_drinks() VALUES (10, 3);
INSERT INTO barabend.bars_drinks() VALUES (14, 1);
INSERT INTO barabend.bars_drinks() VALUES (14, 2);
INSERT INTO barabend.bars_drinks() VALUES (15, 2);
INSERT INTO barabend.bars_drinks() VALUES (17, 1);
INSERT INTO barabend.bars_drinks() VALUES (19, 3);
INSERT INTO barabend.bars_drinks() VALUES (20, 1);
INSERT INTO barabend.bars_drinks() VALUES (25, 3);
INSERT INTO barabend.bars_drinks() VALUES (28, 3);
INSERT INTO barabend.bars_drinks() VALUES (32, 3);
INSERT INTO barabend.bars_drinks() VALUES (33, 3);
INSERT INTO barabend.bars_drinks() VALUES (35, 2);
INSERT INTO barabend.bars_drinks() VALUES (35, 3);
INSERT INTO barabend.bars_drinks() VALUES (36, 3);
INSERT INTO barabend.bars_drinks() VALUES (38, 3);
INSERT INTO barabend.bars_drinks() VALUES (39, 3);
INSERT INTO barabend.bars_drinks() VALUES (40, 2);
INSERT INTO barabend.bars_drinks() VALUES (40, 3);
INSERT INTO barabend.bars_drinks() VALUES (41, 1);
INSERT INTO barabend.bars_drinks() VALUES (42, 2);
INSERT INTO barabend.bars_drinks() VALUES (44, 1);
INSERT INTO barabend.bars_drinks() VALUES (44, 3);
INSERT INTO barabend.bars_drinks() VALUES (49, 3);
INSERT INTO barabend.bars_drinks() VALUES (51, 2);
INSERT INTO barabend.bars_drinks() VALUES (52, 3);
INSERT INTO barabend.bars_drinks() VALUES (57, 2);
INSERT INTO barabend.bars_drinks() VALUES (58, 1);
INSERT INTO barabend.bars_drinks() VALUES (61, 3);
INSERT INTO barabend.bars_drinks() VALUES (63, 2);
INSERT INTO barabend.bars_drinks() VALUES (63, 3);
INSERT INTO barabend.bars_drinks() VALUES (75, 3);
UPDATE barabend.drinks SET drink_name='Bier' WHERE drink_id=1;
UPDATE barabend.drinks SET drink_name='Wein' WHERE drink_id=2;
DELETE FROM barabend.drinks WHERE drink_id IN (4,5);
ALTER TABLE barabend.bars DROP COLUMN drinks;
