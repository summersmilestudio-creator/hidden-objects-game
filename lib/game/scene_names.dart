import 'level_data.dart';

/// Localized display names for the 50 scenes. RO names live in [LevelGenerator]
/// (the fallback). For any of the 10 non-ro locales we return the translated
/// name; otherwise the caller falls back to the RO name passed in.
///
/// Supported language codes: en, es, pt, fr, de, it, ru, ja, ko, zh.
String sceneNameFor(SceneType scene, String langCode, String roFallback) {
  final byLang = _names[scene];
  if (byLang == null) return roFallback;
  return byLang[langCode] ?? roFallback;
}

const Map<SceneType, Map<String, String>> _names = {
  SceneType.garden: {
    'en': 'Magic Garden', 'es': 'Jardín mágico', 'pt': 'Jardim mágico',
    'fr': 'Jardin magique', 'de': 'Zaubergarten', 'it': 'Giardino magico',
    'ru': 'Волшебный сад', 'ja': '魔法の庭', 'ko': '마법의 정원', 'zh': '魔法花园',
  },
  SceneType.beachSunset: {
    'en': 'Beach at Sunset', 'es': 'Playa al atardecer', 'pt': 'Praia ao pôr do sol',
    'fr': 'Plage au coucher du soleil', 'de': 'Strand bei Sonnenuntergang', 'it': 'Spiaggia al tramonto',
    'ru': 'Пляж на закате', 'ja': '夕暮れのビーチ', 'ko': '노을 진 해변', 'zh': '日落海滩',
  },
  SceneType.forest: {
    'en': 'Mysterious Forest', 'es': 'Bosque misterioso', 'pt': 'Floresta misteriosa',
    'fr': 'Forêt mystérieuse', 'de': 'Geheimnisvoller Wald', 'it': 'Foresta misteriosa',
    'ru': 'Таинственный лес', 'ja': '神秘の森', 'ko': '신비한 숲', 'zh': '神秘森林',
  },
  SceneType.library: {
    'en': 'Old Library', 'es': 'Biblioteca antigua', 'pt': 'Biblioteca antiga',
    'fr': 'Vieille bibliothèque', 'de': 'Alte Bibliothek', 'it': 'Biblioteca antica',
    'ru': 'Старая библиотека', 'ja': '古い図書館', 'ko': '오래된 도서관', 'zh': '古老图书馆',
  },
  SceneType.kitchen: {
    'en': "Grandma's Kitchen", 'es': 'La cocina de la abuela', 'pt': 'A cozinha da vovó',
    'fr': 'La cuisine de grand-mère', 'de': 'Omas Küche', 'it': 'La cucina della nonna',
    'ru': 'Бабушкина кухня', 'ja': 'おばあちゃんの台所', 'ko': '할머니의 부엌', 'zh': '奶奶的厨房',
  },
  SceneType.attic: {
    'en': 'Attic of Treasures', 'es': 'Desván de tesoros', 'pt': 'Sótão dos tesouros',
    'fr': 'Grenier aux trésors', 'de': 'Dachboden voller Schätze', 'it': 'Soffitta dei tesori',
    'ru': 'Чердак с сокровищами', 'ja': '宝物の屋根裏', 'ko': '보물 다락방', 'zh': '藏宝阁楼',
  },
  SceneType.city: {
    'en': 'Night City', 'es': 'Ciudad nocturna', 'pt': 'Cidade noturna',
    'fr': 'Ville de nuit', 'de': 'Nächtliche Stadt', 'it': 'Città notturna',
    'ru': 'Ночной город', 'ja': '夜の街', 'ko': '밤의 도시', 'zh': '夜之城',
  },
  SceneType.beach: {
    'en': 'Tropical Beach', 'es': 'Playa tropical', 'pt': 'Praia tropical',
    'fr': 'Plage tropicale', 'de': 'Tropischer Strand', 'it': 'Spiaggia tropicale',
    'ru': 'Тропический пляж', 'ja': 'トロピカルビーチ', 'ko': '열대 해변', 'zh': '热带海滩',
  },
  SceneType.bedroom: {
    'en': 'Childhood Bedroom', 'es': 'Dormitorio de la infancia', 'pt': 'Quarto de infância',
    'fr': "Chambre d'enfance", 'de': 'Kinderzimmer', 'it': "Camera d'infanzia",
    'ru': 'Детская спальня', 'ja': '子供部屋', 'ko': '어린 시절 침실', 'zh': '童年卧室',
  },
  SceneType.bathroom: {
    'en': 'Vintage Bathroom', 'es': 'Baño vintage', 'pt': 'Banheiro vintage',
    'fr': 'Salle de bain rétro', 'de': 'Vintage-Badezimmer', 'it': 'Bagno vintage',
    'ru': 'Винтажная ванная', 'ja': 'ビンテージの浴室', 'ko': '빈티지 욕실', 'zh': '复古浴室',
  },
  SceneType.livingRoom: {
    'en': 'Cozy Living Room', 'es': 'Sala acogedora', 'pt': 'Sala aconchegante',
    'fr': 'Salon chaleureux', 'de': 'Gemütliches Wohnzimmer', 'it': 'Salotto accogliente',
    'ru': 'Уютная гостиная', 'ja': '居心地のよい居間', 'ko': '아늑한 거실', 'zh': '温馨客厅',
  },
  SceneType.office: {
    'en': "Detective's Office", 'es': 'Oficina del detective', 'pt': 'Escritório do detetive',
    'fr': 'Bureau du détective', 'de': 'Detektivbüro', 'it': "Ufficio del detective",
    'ru': 'Кабинет детектива', 'ja': '探偵の事務所', 'ko': '탐정 사무실', 'zh': '侦探办公室',
  },
  SceneType.workshop: {
    'en': "Inventor's Workshop", 'es': 'Taller del inventor', 'pt': 'Oficina do inventor',
    'fr': "Atelier de l'inventeur", 'de': 'Werkstatt des Erfinders', 'it': "Officina dell'inventore",
    'ru': 'Мастерская изобретателя', 'ja': '発明家の工房', 'ko': '발명가의 작업실', 'zh': '发明家工坊',
  },
  SceneType.cellar: {
    'en': 'Wine Cellar', 'es': 'Bodega de vinos', 'pt': 'Adega de vinhos',
    'fr': 'Cave à vin', 'de': 'Weinkeller', 'it': 'Cantina dei vini',
    'ru': 'Винный погреб', 'ja': 'ワインセラー', 'ko': '와인 저장고', 'zh': '酒窖',
  },
  SceneType.ballroom: {
    'en': 'Masquerade Ball', 'es': 'Baile de máscaras', 'pt': 'Baile de máscaras',
    'fr': 'Bal masqué', 'de': 'Maskenball', 'it': 'Ballo in maschera',
    'ru': 'Маскарад', 'ja': '仮面舞踏会', 'ko': '가면 무도회', 'zh': '化装舞会',
  },
  SceneType.greenhouse: {
    'en': 'Botanical Greenhouse', 'es': 'Invernadero botánico', 'pt': 'Estufa botânica',
    'fr': 'Serre botanique', 'de': 'Botanisches Gewächshaus', 'it': 'Serra botanica',
    'ru': 'Ботаническая оранжерея', 'ja': '植物温室', 'ko': '식물 온실', 'zh': '植物温室',
  },
  SceneType.cave: {
    'en': 'Crystal Cave', 'es': 'Cueva de cristales', 'pt': 'Caverna de cristais',
    'fr': 'Grotte de cristal', 'de': 'Kristallhöhle', 'it': 'Grotta dei cristalli',
    'ru': 'Хрустальная пещера', 'ja': '水晶の洞窟', 'ko': '수정 동굴', 'zh': '水晶洞穴',
  },
  SceneType.castle: {
    'en': 'Lost Castle', 'es': 'Castillo perdido', 'pt': 'Castelo perdido',
    'fr': 'Château perdu', 'de': 'Verlorenes Schloss', 'it': 'Castello perduto',
    'ru': 'Затерянный замок', 'ja': '失われた城', 'ko': '잃어버린 성', 'zh': '失落的城堡',
  },
  SceneType.dungeon: {
    'en': "Dragon's Dungeon", 'es': 'Mazmorra del dragón', 'pt': 'Masmorra do dragão',
    'fr': 'Donjon du dragon', 'de': 'Drachenverlies', 'it': 'Segreta del drago',
    'ru': 'Подземелье дракона', 'ja': '竜の地下牢', 'ko': '용의 던전', 'zh': '巨龙地牢',
  },
  SceneType.ship: {
    'en': 'Pirate Ship', 'es': 'Barco pirata', 'pt': 'Navio pirata',
    'fr': 'Navire pirate', 'de': 'Piratenschiff', 'it': 'Nave dei pirati',
    'ru': 'Пиратский корабль', 'ja': '海賊船', 'ko': '해적선', 'zh': '海盗船',
  },
  SceneType.underwater: {
    'en': 'Marine Depths', 'es': 'Profundidades marinas', 'pt': 'Profundezas marinhas',
    'fr': 'Profondeurs marines', 'de': 'Meerestiefen', 'it': 'Profondità marine',
    'ru': 'Морские глубины', 'ja': '海の深淵', 'ko': '바다 심해', 'zh': '海洋深处',
  },
  SceneType.spaceStation: {
    'en': 'Space Station', 'es': 'Estación espacial', 'pt': 'Estação espacial',
    'fr': 'Station spatiale', 'de': 'Raumstation', 'it': 'Stazione spaziale',
    'ru': 'Космическая станция', 'ja': '宇宙ステーション', 'ko': '우주 정거장', 'zh': '太空站',
  },
  SceneType.observatory: {
    'en': 'Stellar Observatory', 'es': 'Observatorio estelar', 'pt': 'Observatório estelar',
    'fr': 'Observatoire stellaire', 'de': 'Sternwarte', 'it': 'Osservatorio stellare',
    'ru': 'Звёздная обсерватория', 'ja': '天文台', 'ko': '천문대', 'zh': '星空天文台',
  },
  SceneType.magicShop: {
    'en': 'Magic Shop', 'es': 'Tienda mágica', 'pt': 'Loja mágica',
    'fr': 'Boutique magique', 'de': 'Zauberladen', 'it': 'Bottega magica',
    'ru': 'Магическая лавка', 'ja': '魔法の店', 'ko': '마법 상점', 'zh': '魔法商店',
  },
  SceneType.desert: {
    'en': 'Desert Oasis', 'es': 'Oasis del desierto', 'pt': 'Oásis no deserto',
    'fr': 'Oasis du désert', 'de': 'Wüstenoase', 'it': 'Oasi nel deserto',
    'ru': 'Оазис в пустыне', 'ja': '砂漠のオアシス', 'ko': '사막의 오아시스', 'zh': '沙漠绿洲',
  },
  SceneType.snow: {
    'en': 'Snowy Cabin', 'es': 'Cabaña nevada', 'pt': 'Cabana nevada',
    'fr': 'Chalet enneigé', 'de': 'Verschneite Hütte', 'it': 'Baita innevata',
    'ru': 'Заснеженная хижина', 'ja': '雪の山小屋', 'ko': '눈 덮인 오두막', 'zh': '雪屋',
  },
  SceneType.circus: {
    'en': 'Circus Tent', 'es': 'Carpa del circo', 'pt': 'Tenda do circo',
    'fr': 'Chapiteau du cirque', 'de': 'Zirkuszelt', 'it': 'Tendone del circo',
    'ru': 'Цирковой шатёр', 'ja': 'サーカスのテント', 'ko': '서커스 천막', 'zh': '马戏团帐篷',
  },
  SceneType.carnival: {
    'en': 'Merry Carnival', 'es': 'Feria alegre', 'pt': 'Parque de diversões',
    'fr': 'Fête foraine', 'de': 'Fröhlicher Jahrmarkt', 'it': 'Allegro luna park',
    'ru': 'Весёлая ярмарка', 'ja': '楽しいカーニバル', 'ko': '즐거운 카니발', 'zh': '欢乐嘉年华',
  },
  SceneType.bakery: {
    'en': "Grandma's Bakery", 'es': 'La panadería de la abuela', 'pt': 'A padaria da vovó',
    'fr': 'La boulangerie de grand-mère', 'de': 'Omas Bäckerei', 'it': 'Il forno della nonna',
    'ru': 'Бабушкина пекарня', 'ja': 'おばあちゃんのパン屋', 'ko': '할머니의 빵집', 'zh': '奶奶的面包房',
  },
  SceneType.cafe: {
    'en': 'Parisian Café', 'es': 'Café parisino', 'pt': 'Café parisiense',
    'fr': 'Café parisien', 'de': 'Pariser Café', 'it': 'Caffè parigino',
    'ru': 'Парижское кафе', 'ja': 'パリのカフェ', 'ko': '파리 카페', 'zh': '巴黎咖啡馆',
  },
  SceneType.flowerShop: {
    'en': 'Corner Flower Shop', 'es': 'Floristería de la esquina', 'pt': 'Floricultura da esquina',
    'fr': 'Fleuriste du coin', 'de': 'Blumenladen an der Ecke', 'it': 'Fiorista all\'angolo',
    'ru': 'Цветочный магазин на углу', 'ja': '街角の花屋', 'ko': '모퉁이 꽃집', 'zh': '街角花店',
  },
  SceneType.toyStore: {
    'en': 'Toy Store', 'es': 'Juguetería', 'pt': 'Loja de brinquedos',
    'fr': 'Magasin de jouets', 'de': 'Spielzeugladen', 'it': 'Negozio di giocattoli',
    'ru': 'Магазин игрушек', 'ja': 'おもちゃ屋', 'ko': '장난감 가게', 'zh': '玩具店',
  },
  SceneType.toolShed: {
    'en': 'Tool Shed', 'es': 'Cobertizo de herramientas', 'pt': 'Galpão de ferramentas',
    'fr': 'Cabane à outils', 'de': 'Geräteschuppen', 'it': 'Capanno degli attrezzi',
    'ru': 'Сарай с инструментами', 'ja': '道具小屋', 'ko': '연장 창고', 'zh': '工具棚',
  },
  SceneType.musicRoom: {
    'en': 'Music Room', 'es': 'Sala de música', 'pt': 'Sala de música',
    'fr': 'Salle de musique', 'de': 'Musikzimmer', 'it': 'Sala della musica',
    'ru': 'Музыкальная комната', 'ja': '音楽室', 'ko': '음악실', 'zh': '音乐室',
  },
  SceneType.artStudio: {
    'en': 'Art Studio', 'es': 'Estudio de arte', 'pt': 'Ateliê de arte',
    'fr': "Atelier d'art", 'de': 'Kunstatelier', 'it': "Studio d'arte",
    'ru': 'Художественная студия', 'ja': 'アトリエ', 'ko': '미술 작업실', 'zh': '艺术工作室',
  },
  SceneType.gym: {
    'en': 'Gym', 'es': 'Gimnasio', 'pt': 'Academia',
    'fr': 'Salle de sport', 'de': 'Fitnessstudio', 'it': 'Palestra',
    'ru': 'Спортзал', 'ja': 'ジム', 'ko': '체육관', 'zh': '健身房',
  },
  SceneType.laundry: {
    'en': 'Laundry Room', 'es': 'Lavandería', 'pt': 'Lavanderia',
    'fr': 'Buanderie', 'de': 'Waschküche', 'it': 'Lavanderia',
    'ru': 'Прачечная', 'ja': 'ランドリー', 'ko': '세탁실', 'zh': '洗衣房',
  },
  SceneType.pharmacy: {
    'en': 'Old Pharmacy', 'es': 'Farmacia antigua', 'pt': 'Farmácia antiga',
    'fr': 'Vieille pharmacie', 'de': 'Alte Apotheke', 'it': 'Farmacia antica',
    'ru': 'Старая аптека', 'ja': '古い薬局', 'ko': '오래된 약국', 'zh': '老药房',
  },
  SceneType.fishMarket: {
    'en': 'Fish Market', 'es': 'Mercado de pescado', 'pt': 'Mercado de peixe',
    'fr': 'Marché aux poissons', 'de': 'Fischmarkt', 'it': 'Mercato del pesce',
    'ru': 'Рыбный рынок', 'ja': '魚市場', 'ko': '수산 시장', 'zh': '鱼市',
  },
  SceneType.candyShop: {
    'en': 'Candy Shop', 'es': 'Tienda de dulces', 'pt': 'Loja de doces',
    'fr': 'Confiserie', 'de': 'Süßwarenladen', 'it': 'Negozio di dolci',
    'ru': 'Кондитерская лавка', 'ja': 'お菓子屋', 'ko': '사탕 가게', 'zh': '糖果店',
  },
  SceneType.jewelryStore: {
    'en': 'Jewelry Store', 'es': 'Joyería', 'pt': 'Joalheria',
    'fr': 'Bijouterie', 'de': 'Juweliergeschäft', 'it': 'Gioielleria',
    'ru': 'Ювелирный магазин', 'ja': '宝石店', 'ko': '보석 가게', 'zh': '珠宝店',
  },
  SceneType.barberShop: {
    'en': 'Retro Barber Shop', 'es': 'Barbería retro', 'pt': 'Barbearia retrô',
    'fr': 'Salon de coiffure rétro', 'de': 'Retro-Friseursalon', 'it': 'Barbiere retrò',
    'ru': 'Ретро-парикмахерская', 'ja': 'レトロな理髪店', 'ko': '복고풍 이발소', 'zh': '复古理发店',
  },
  SceneType.gasStation: {
    'en': 'Gas Station', 'es': 'Gasolinera', 'pt': 'Posto de gasolina',
    'fr': 'Station-service', 'de': 'Tankstelle', 'it': 'Stazione di servizio',
    'ru': 'Заправка', 'ja': 'ガソリンスタンド', 'ko': '주유소', 'zh': '加油站',
  },
  SceneType.barn: {
    'en': 'Farm Barn', 'es': 'Granero de la granja', 'pt': 'Celeiro da fazenda',
    'fr': 'Grange de la ferme', 'de': 'Bauernhofscheune', 'it': 'Fienile della fattoria',
    'ru': 'Фермерский амбар', 'ja': '農場の納屋', 'ko': '농장 헛간', 'zh': '农场谷仓',
  },
  SceneType.vineyard: {
    'en': 'Vineyard Cellar', 'es': 'Bodega del viñedo', 'pt': 'Adega da vinha',
    'fr': 'Cave du vignoble', 'de': 'Weingutkeller', 'it': 'Cantina del vigneto',
    'ru': 'Винодельня', 'ja': 'ブドウ園の醸造所', 'ko': '포도밭 양조장', 'zh': '葡萄园酒窖',
  },
  SceneType.lighthouse: {
    'en': 'Seaside Lighthouse', 'es': 'Faro junto al mar', 'pt': 'Farol à beira-mar',
    'fr': 'Phare au bord de mer', 'de': 'Leuchtturm am Meer', 'it': 'Faro sul mare',
    'ru': 'Маяк у моря', 'ja': '海辺の灯台', 'ko': '바닷가 등대', 'zh': '海边灯塔',
  },
  SceneType.aquarium: {
    'en': 'Public Aquarium', 'es': 'Acuario público', 'pt': 'Aquário público',
    'fr': 'Aquarium public', 'de': 'Öffentliches Aquarium', 'it': 'Acquario pubblico',
    'ru': 'Городской аквариум', 'ja': '水族館', 'ko': '공공 수족관', 'zh': '公共水族馆',
  },
  SceneType.museum: {
    'en': 'History Museum', 'es': 'Museo de historia', 'pt': 'Museu de história',
    'fr': "Musée d'histoire", 'de': 'Geschichtsmuseum', 'it': 'Museo di storia',
    'ru': 'Исторический музей', 'ja': '歴史博物館', 'ko': '역사 박물관', 'zh': '历史博物馆',
  },
  SceneType.classroom: {
    'en': 'Classroom', 'es': 'Aula', 'pt': 'Sala de aula',
    'fr': 'Salle de classe', 'de': 'Klassenzimmer', 'it': 'Aula scolastica',
    'ru': 'Классная комната', 'ja': '教室', 'ko': '교실', 'zh': '教室',
  },
  SceneType.playground: {
    'en': 'Playground', 'es': 'Parque infantil', 'pt': 'Parquinho',
    'fr': 'Aire de jeux', 'de': 'Spielplatz', 'it': 'Parco giochi',
    'ru': 'Детская площадка', 'ja': '遊び場', 'ko': '놀이터', 'zh': '游乐场',
  },
};
