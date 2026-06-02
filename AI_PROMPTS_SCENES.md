# Hidden Objects — prompts AI pentru 8 scene 3D-rendate

User vrea look 3D (NU pictura 2D ca în captura competitorului). Generăm prin
AI scene rendate 3D (Pixar/Blender style) salvate ca PNG. Codul jocului
încarcă automat fișierele PNG din `assets/scenes/<nume>.png` și se cad pe
pictura geometrică existentă dacă lipsesc.

Dimensiuni: **1290×2796 portrait** (iPhone 17 Pro Max).
Stil global: **3D rendered, Pixar/Disney CGI, cinematic lighting, depth of
field, octane/unreal-engine render, hyper-detailed, photoreal but stylized**.

Pentru senzație de adâncime, codul aplică automat un efect parallax/tilt 3D
peste PNG (`Scene3DEffect`) — nu trebuie să faci nimic la PNG.

---

## 1. garden — `assets/scenes/garden.png`
```
A lush summer garden, fully 3D rendered in Pixar style with cinematic depth
of field. Stone path winding between flower beds, a wooden bench, ceramic
pots, brass watering can, gardening tools, butterfly net, picnic basket with
bread and grapes, straw hat hanging on a fence, garden gnome partly hidden
in bushes, small wooden birdhouse. 30+ small props arranged naturally for a
hidden-object game. Warm afternoon volumetric light, dappled shadows, soft
bokeh. Octane render quality, vibrant materials, sharp highlights, painter's
palette of greens with peach sky. --ar 9:20 --style raw --v 6 --quality 2
```

## 2. beachSunset — `assets/scenes/beachSunset.png`
```
3D rendered Romanian Black Sea beach at golden hour, Pixar/Disney CGI style.
Wooden lifeguard chair, scattered seashells, forgotten flip-flops, vintage
camera in the sand, paper boat at waterline, binoculars on a beach towel,
picnic cooler half-open with bottles, surfboard leaning, small treasure chest
barely buried, sunglasses, beach ball. Subsurface scattering on shells, wet
sand reflections of the sun, two palm-tree silhouettes. Octane render, depth
of field, cinematic warm orange-pink horizon. --ar 9:20 --style raw --v 6
```

## 3. forest — `assets/scenes/forest.png`
```
3D rendered enchanted twilight forest clearing, Pixar style with volumetric
god-rays through canopy. Ancient mossy tree, glowing mushrooms with
subsurface scattering, lantern hanging from a branch, owl perched in a
hollow, fox tail visible behind a log, scattered acorns and pinecones, a
leather-bound book on a rock, magnifying glass, gnome figurine, dreamcatcher,
mushroom-shaped lamp on the ground, crystal cluster, golden compass, butterfly
net, wicker basket with berries. Deep teal-green palette, Disney-style
material PBR, cinematic depth of field. --ar 9:20 --style raw --v 6
```

## 4. library — `assets/scenes/library.png`
```
3D rendered cozy old library nook, Pixar style. Tall mahogany bookshelves
filled with hundreds of colorful spines and small trinkets: globe, magnifying
glass, brass key, vintage typewriter, old camera, hourglass, telescope,
fountain pen and inkwell, scroll, candle, pocket watch on a string, framed
photo, antique pipe, gold-trimmed boxes, a cat curled on a stack of books, a
wizard hat, butterfly under glass, small skull on a shelf. Warm amber lamp
light, leather armchair foreground, Persian rug. Octane render, depth of
field, hyper-detailed PBR materials. --ar 9:20 --style raw --v 6
```

## 5. kitchen — `assets/scenes/kitchen.png`
```
3D rendered rustic country kitchen interior, Pixar/Disney CGI style with
photorealistic PBR materials and Pixar-style stylization (think Find Hidden
Objects scenes but fully 3D). Open window with sea view, hanging copper pots,
colorful enameled coffee mugs on shelves, spice rack with labeled jars,
wooden cutting board with bread and tomatoes, kettle, cast-iron skillet with
sunny-side-up eggs and bacon, garlic braids hanging, fresh herbs in clay
pots, vintage red-and-white-striped napkins, ceramic chicken figurine, glass
shaker, ladle, rolling pin, cookbook propped open, basket of fresh fruit,
wall clock, embroidered tea towel, oven mitts, salt and pepper grinders. Tile
checkered floor, sage-green painted cabinets. Octane render, cinematic
lighting, shallow depth of field, ~30 hidden items naturally placed.
--ar 9:20 --style raw --v 6 --quality 2
```

## 6. attic — `assets/scenes/attic.png`
```
3D rendered grandparent's attic at dusk, Pixar style chiaroscuro lighting,
dust motes in shafts of light from a small round window. Wooden beams, old
steamer trunk half-open, vintage porcelain dolls, rocking horse, accordion,
gramophone with horn, framed sepia photos, oil lamp, treasure chest with
brass corners, taxidermy bird in glass dome, antique globe, telegraph key,
pocket watch on chain, ship-in-a-bottle, brass telescope, magnifying glass,
fountain pen, music box, hanging propeller, captain's hat, leather journal,
key ring. Octane render, depth of field, atmospheric, painterly mood.
--ar 9:20 --style raw --v 6
```

## 7. city — `assets/scenes/city.png`
```
3D rendered Bucharest old town rooftop at night, Pixar style. Lit-up
apartment windows, glowing neon sign, clothesline strung between balconies
with shirts, satellite dishes, stray cat on a chimney, fairy lights,
terracotta plant pots, abandoned bicycle, stack of newspapers, forgotten
suitcase, pigeon on a ledge, weather vane on a tower, hidden gargoyle on a
corner, hot-air balloon in the distance, paper airplane, telescope on a deck,
hidden treasure map glued to a wall. Velvet night sky with stars, warm-orange
city glow. Octane render, cinematic depth of field. --ar 9:20 --style raw --v 6
```

## 8. beach — `assets/scenes/beach.png`
```
3D rendered tropical Romanian summer beach at midday, Pixar style.
Subsurface scattering on water, palm trees framing the scene, calm turquoise
sea, scattered seashells, sandcastle with a tiny flag, beach umbrella with
red-white stripes, snorkeling mask, swim fins, vintage Polaroid camera,
inflatable flamingo, paddleboard half-buried, picnic basket with watermelon
slices, ice-cream cone melting in sand, beach volleyball, kite tangled in a
palm, treasure map sticking out, brass spyglass, sunglasses, suntan lotion
bottle, ukulele on a towel, lifebuoy, captain's hat on driftwood. Warm sand
with translucent grains, clear blue sky. Octane render, hyper-detailed PBR
materials, shallow depth of field. --ar 9:20 --style raw --v 6 --quality 2
```

---

## Stil 3D — variante (alege una și păstrează consistentă pe toate 8)
- **Pixar/Disney CGI** (recomandat): cel mai accesibil pe Midjourney/DALL-E
- **Octane render hyper-realistic**: mai aproape de gravity de gen Lara Croft
- **Blender Eevee stylized**: dacă vrei vibe indie
- **ZBrush sculpt + KeyShot**: pentru obiecte mărunte super detaliate

## După generare
1. Salvează fiecare PNG cu numele exact (ex. `kitchen.png`) în
   `D:\hidden_objects\assets\scenes\`
2. `D:\flutter\bin\flutter.bat build appbundle --release`
3. Codul aplică automat efectul parallax 3D (gyroscope/tilt) peste imaginea
   2D rendered → senzație de adâncime fără să încarci un model 3D real.
4. Fallback: dacă PNG-ul lipsește, jocul folosește pictura geometrică actuală.
