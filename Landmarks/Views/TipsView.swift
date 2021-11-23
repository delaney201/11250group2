import SwiftUI
import EventKit
import EventKitUI


struct tips: Identifiable{
    let id = UUID()
    let tip: String
    var items: [tips]?
    
    static let compost1 = tips(tip:"Try to mix the ratio of 1/3 greens (nitrogen) and 2/3 browns (carbon) in your composting bin to reduce flies and odor")
    static let compost2 = tips(tip:"Consider more than just food as a compostable. Natural fabrics, wood, shredded fallen leaves, and bamboo products can be used as well!")
    static let compost3 = tips(tip:"Size your compost bin based on the size of your garden, small garden = small compost bin and large garden = large compost bin")
    static let compost4 = tips(tip:"If you see fungi growing in your compost pile, aerate the compost pile to maintain a balance of nitrogen and cellulose materials")
    static let compost5 = tips(tip:"Apply compost 2-3 inches deep but keep it about 1 inch from your plant stems")
    static let compost6 = tips(tip:"Don't try to compost fats, pet droppings or animal products, it will attract pests to yout pile!")
    static let compost7 = tips(tip:"Your compost is finished if it is more dense but less than half the volume of the materials you started with")
    static let compost8 = tips(tip:"The ideal temperature for decomposition is 120-160 degrees Farenheit")
    static let compost9 = tips(tip:"Apply finished compost about 2-4 weeks before planting. This will give the compost time to integrate and stabilize within the soil")

    static let general1 = tips(tip:"Put out a bucket to collect rainwater, this can be used to water your plants later!")
    static let general2 = tips(tip:"Remember to disinfect pruning tools between cuts to avoid spreading disease")
    static let general3 = tips(tip:"When watering, count to 3 seconds with the water pooled at the top for an ideal amount of water")
    static let general4 = tips(tip:"When using transplants, keep the soil type consistent")
    static let general5 = tips(tip:"Avoid digging or planting in wet soil")
    static let general6 = tips(tip:"When transfering a potted plant to soil, dig a hole that twice as wide as the soil ball to aid with root establishment")
    static let general7 = tips(tip:"Remove the old blooms of perennials and annuals to allow them to produce more flowers")
    static let general8 = tips(tip:"Applying a layer of 2-3 inches of mulch around each plant can reduce weeds!")
    static let general9 = tips(tip:"Choose your sunlight wisely! Most edible plants need atleast 6 hours of sunlight a day to survive")
    static let general10 = tips(tip:"Place your garden somewhere you see it regularly so you are more likely to spend time there")
    
    static let indoor1 = tips(tip:"Interior plants need less water in winter. A major cause of killing any kind of plant is over-watering. Air spaces in the soil get choked with water. Plant roots need air as much as they need water and nutrients.")
    static let indoor2 = tips(tip:"HOLD THE FERTILIZER - Plants are dormant in the winter and do not need an artificial boost of growing power.")
    static let indoor3 = tips(tip:"To accommodate low light levels, keep leafy plants clean. Dust cuts down on the light necessary for photosynthesis, which feeds the plant.")
    static let indoor4 = tips(tip:"To combat dry indoor air, put rocks or pebbles in saucers, and fill with water. Be sure the bottom of the pot is not touching or standing in the water. Group plants together for more humidity, or run a humidifier or vaporizer.")
    static let indoor5 = tips(tip:"In February, the lengthening days will produce new growth on your houseplants. Your indoor garden will need more water and some organic fertilizer. Continue to check for water, and fertilize at half-strength. As the days continue to get longer and warmer, water and fertilizer will need to be increased.")
    static let indoor6 = tips(tip:"Late winter is also time to prune your houseplants. They may have gotten leggy with the low winter light, but you also want to encourage new growth.")
    static let indoor7 = tips(tip:"Remove the plant from its pot, trim the root ball back, and put it in a clean pot the same size with new potting soil. If it is really pot bound, break up the root ball a bit, and put up to a size 1-2” larger.")
    
    
    static let pollinators1 = tips(tip:"Different pollinators respond to different colors. Bees prefer blue, yellow, white and purple, while hummingbirds zoom to red-toned blooms first. Butterflies favor red and purple tones. Fill your yard with flowers in a rainbow of hues, and choose plants that bloom at different times so you’ll have blossoms throughout the growing season.")
    static let pollinators2 = tips(tip:"Planting flowers with a variety of bloom shapes—some tall, some short, some wide, some narrow— will help draw a diverse group of pollinators.")
    static let pollinators3 = tips(tip:"Many pollinators are near-sighted, so it’s easier for them to find flowers when there’s a large bunch. Arrange your plants in groups of 3 or 5 to mimic nature’s planting style and provide a can’t-miss target for pollinators.")
    static let pollinators4 = tips(tip:"Like any living creature, pollinators need water to survive. Include a shallow bird bath, fountain, or pond to give pollinators a place to sip.")
    static let pollinators5 = tips(tip:"Pollinators need places to hide and raise their young, such as a hedge, a compost pile, a dead tree, unmowed grass, or unmulched soil. Be sure to provide just such a retreat near your pollinator garden.")
    static let pollinators6 = tips(tip:"Include trees and shrubs in your pollinator plans. A maple or crabapple tree in flower literally buzzes with activity during bloom time. Shrubs like viburnum, butterfly bush, spirea, and summersweet offer nectar-laden flowers that pollinators can’t resist.")
    static let pollinators7 = tips(tip:"Once you’re done harvesting your favorite culinary herbs, allow them to burst into bloom. Pollinators will mob them! Bees are particularly fond of mint, oregano, basil, dill, fennel, and rosemary flowers, so why not indulge them?")
    static let pollinators8 = tips(tip:"Flowers that attract butterflies: Salvia coccinea, Mexican sunflower, yarrow, butterfly weed, liatris (aka blazing star), butterfly bush.")
    static let pollinators9 = tips(tip:"Flowers that attract hummingbirds: Penstemon (aka beard tongue), honeysuckle, torch lily (aka red hot poker), salvia (all types), hummingbird mint, trumpet vine.")
    static let pollinators10 = tips(tip:"Flowers that attract bees: Bee balm, purple coneflower, dill, mint, sunflower, Joe-Pye weed.")
    
    static let pesticides1 = tips(tip:"Nourish your plants with organic amendments such as aged compost. Strong plants don't attract as many insects and can withstand their assault better than weak ones. If you're using fertilizer, follow instructions closely. Over-fertilized plants will attract pests to eat their lush new growth.")
    static let pesticides2 = tips(tip:"Use companion planting to repel insects naturally. Some plants thrive together; some do not.")
    static let pesticides3 = tips(tip:"Use barriers like row covers to block pests from attacking your plants, especially tender transplants. (Remove the covers when plants are established and in bloom to allow for insect pollination.) Additionally, \"collars\" (paper towel or toilet paper cardboard rolls) inserted around the small transplants (1 to 2 inches into the soil) will prevent insects such as cutworms from eating the young stems.")
    static let pesticides4 = tips(tip:"Time plantings to avoid peak insect populations. For example, plant squash as early as possible to avoid squash vine borers, which lay eggs in early to mid-summer. Plant carrots after June 1 and harvest by early September to avoid the carrot fly.")
    static let pesticides5 = tips(tip:"Select varieties that are naturally resistant to some pests.")
    static let pesticides6 = tips(tip:"Make your garden welcoming to beneficial insects and they will do a lot of the work for you by keeping the bugs they feed on in check.")
    static let pesticides7 = tips(tip:"Learn to identify the bugs in your garden. You can't beat them if you don't know who is friend and who is foe. Learn what their larvae and eggs look like to head them off before they become adults.")
    
    static let weedControl1 = tips(tip:"Digging and cultivating brings hidden weed seeds to the surface, so assume weed seeds are there ready to erupt")
    static let weedControl2 = tips(tip:"In lawns, minimize soil disturbance by using a sharp knife with a narrow blade to slice through the roots of dandelions and other lawn weeds to sever their feed source rather than digging them out")
    static let weedControl3 = tips(tip:"Use mulch to keep the soil cool and moist and deprive weeds of light.")
    static let weedControl4 = tips(tip:"After a drenching rain, stage a rewarding weeding session by equipping yourself with gloves, a sitting pad, and a trug or tarp for collecting the dead weeds")
    static let weedControl5 = tips(tip:"Under dry conditions, weeds sliced off just below the soil line promptly shrivel up and die, especially if your hoe has a sharp edge")
    static let weedControl6 = tips(tip:"Cutting back the tops of perennial weeds, like bindweed, reduces reseeding and forces them to use up food reserves and exhaust their supply of root buds, thus limiting their spread")
    static let weedControl7 = tips(tip:"You can prevent weed-friendly gaps between plants by designing mass plantings or planting in drifts of closely spaced plants rather than with polka dots of widely scattered ones ")
    static let weedControl8 = tips(tip:"Placing drip or soaker hoses beneath mulch efficiently irrigates plants while leaving nearby weeds thirsty")
    static let weedControl9 = tips(tip:"Use different heights of plants to build layers that shade the soil, making an unwelcome environment for weed seed germination")
    static let weedControl10 = tips(tip:"The trick to pulling weeds is to get the root out as well, since many common weeds—like dandelions—will regrow from any roots left in the ground")
    
    static let vegetable1 = tips(tip:"If it's getting cold and you have tomatoes still ripening on the vine — save your tomatoes! Pull the plants up and bring them inside to a warm dry place. Hang them up, and the tomatoes will ripen on the vine")
    static let vegetable2 = tips(tip:"Companion planting is an excellent way to improve your garden. Some plants replenish nutrients lost by another one")
    static let vegetable3 = tips(tip:"When transplanting tomatoes, cover the stem with soil all the way up to the first set of leaves")
    static let vegetable4 = tips(tip:"Like vining vegetables, but don’t have the room? Train your melons, squash, and cucumbers onto a vertical trellis or fence")
    static let vegetable5 = tips(tip:"Garden vegetables that become overripe are an easy target for some pests. Remove them as soon as possible to avoid detection")
    static let vegetable6 = tips(tip:"Onions are ready to harvest when the tops have fallen over. Let the soil dry out, harvest, and store in a warm, dry, dark place until the tops dry. Cut off the foliage down to an inch, then store in a cool, dry area")
    static let vegetable7 = tips(tip:"Keep dirt off lettuce and cabbage leaves when growing by spreading a 1-2 inch layer of mulch (untreated by pesticides or fertilizers) around each plant")
    static let vegetable8 = tips(tip:"Milk jugs, soda bottles and other plastic containers make great mini-covers to place over your plants and protect them from frost in the winter")
    static let vegetable9 = tips(tip:"For easy peas, start them indoors. The germination rate is far better, and the seedlings will be healthier and better able to fight off pests and disease")
    static let vegetable10 = tips(tip:"If you’re short on space, garlic, leeks and shallots make excellent container plants")
    
    static let animal1 = tips(tip:"Spritz liquids with an offensive odor or taste to stop animals from eating the plants in your garden")
    static let animal2 = tips(tip:"Any animal repellent spray (commercial or homemade) needs to be reapplied frequently as plants grow or rain washes it away to stay effective")
    static let animal3 = tips(tip:"Predator urine is a good option for a store-bought repellent that works on specific animals")
    static let animal4 = tips(tip:"You can add alternative food sources to each end of your garden, like a bird feeder, to distract animals")
    static let animal5 = tips(tip:"Mix 1/4 cup milk, 4 drops of natural dish soap and water to a spray bottle and spray on your plants every 10 days to keep deer away")
    static let animal6 = tips(tip:"Skewer a bar of soap and stick it into the ground around young plants to keep deer and squirrels from munching on your garden")
    static let animal7 = tips(tip:"Herbs such as mint and lavender have been known to keep pests away due to their taste")
    static let animal8 = tips(tip:"Try spooking animals by hanging a wind chime near your garden or if possible, keep a radio nearby. The noise will keep some animals, notably deer, away from your garden")
    static let animal9 = tips(tip:"If there’s a plant that is particularly appealing to local pests, consider covering it with garden fabric. Use garden hoops to support the fabric and secure the fabric to the ground on all four sides, creating a small enclosure")
    static let animal10 = tips(tip:"If neighborhood cats are getting into your plants, try placing catnip in small pots on your patio or in a planter box on the other side of your yard (away from your garden)")
    
    static let winter1 = tips(tip:"Selectively remove branches to provide clearance, reduce risk of breakage, or reduce size to prepare for the Florida winter months")
    static let winter2 = tips(tip:"Mulch will insulate the plant absorbing the sun’s radiation using it at night to keep your plants, flowers and trees warm, just like a blanket uses our body heat to keep us warm at night")
    static let winter3 = tips(tip:"Continue to water newly planted plants, trees, and shrubs since it doesn’t rain often in Florida during the winter")
    static let winter4 = tips(tip:"Cover tender plants by using cloth, such as old sheets or quilts, burlap or special covering from local nurseries that is made for plants and always avoid using plastic")
    static let winter5 = tips(tip:"When using outdoor holiday lighting and/or decorations that require electricity, be careful when running extension cords and other power sources on the ground or through your landscaping")
    static let winter6 = tips(tip:"The last recommended time to fertilize your lawn in North and Central Florida is October/November. A high-potassium fertilizer would be best for this time of year")
    static let winter7 = tips(tip:"If you are planting from seeds, it is best to get them in the ground before the 2nd week of October. This will allow your plants to get firmly established before we start having really chilly nights")
    static let winter8 = tips(tip:"Fences, buildings, temporary coverings, and adjacent plantings can all serve as windbreaks and protect plants from cold winds")
    static let winter9 = tips(tip:"Arugula, Beets, Broccoli, Lettuce, and Brussel Sprouts are some of many vegetables that grow well in winter temperatures")
    static let winter10 = tips(tip:"Tree cover can reduce cold injury during some freezes. Areas under tree canopies can reach a higher temperature overnight because the canopy traps heat radiating from the ground")
    
   
    
    static let compostingTips = tips(tip: "Composting Tips", items: [tips.compost1, tips.compost2,tips.compost3,tips.compost4,tips.compost5,tips.compost6,tips.compost7,tips.compost8,tips.compost9])
    
    static let generalTips = tips(tip: "General Tips", items: [tips.general1, tips.general2,tips.general3,tips.general4,tips.general5,tips.general6,tips.general7,tips.general8,tips.general9,tips.general10])
    
    static let indoorTips = tips(tip: "Indoor Gardening Tips", items: [tips.indoor1, tips.indoor2,tips.indoor3,tips.indoor4,tips.indoor5,tips.indoor6,tips.indoor7])
    
    static let pollinatorTips = tips(tip: "Attracting Pollinators Tips", items: [tips.pollinators1, tips.pollinators2,tips.pollinators3,tips.pollinators4,tips.pollinators5,tips.pollinators6,tips.pollinators7,tips.pollinators8,tips.pollinators9, tips.pollinators10])
    
    static let pesticidesTips = tips(tip: "Pesticides Tips", items: [tips.pesticides1, tips.pesticides2,tips.pesticides3,tips.pesticides4,tips.pesticides5,tips.pesticides6,tips.pesticides7])
    
    static let weedControlTips = tips(tip: "Weed Control Tips", items: [tips.weedControl1, tips.weedControl2,tips.weedControl3,tips.weedControl4,tips.weedControl5,tips.weedControl6,tips.weedControl7,tips.weedControl8,tips.weedControl9, tips.weedControl10])
    static let vegetableGardeningTips = tips(tip: "Vegetable Gardening Tips", items: [tips.vegetable1, tips.vegetable2,tips.vegetable3,tips.vegetable5,tips.vegetable6,tips.vegetable4,tips.vegetable7,tips.vegetable8,tips.vegetable9, tips.vegetable10])
    
    static let animalGardeningTips = tips(tip: "Animal Pest Control Tips", items: [tips.animal1, tips.animal2,tips.animal3,tips.animal5,tips.animal6,tips.animal4,tips.animal7,tips.animal8,tips.animal9, tips.animal10])
    
    static let winterGardeningTips = tips(tip: "Winter Gardening Tips", items: [tips.winter1, tips.winter2,tips.winter3,tips.winter5,tips.winter6,tips.winter4,tips.winter7,tips.winter8,tips.winter9, tips.winter10])

}


struct TipsView: View {
    let items: [tips] = [.generalTips,.indoorTips,.compostingTips,.pollinatorTips,.pesticidesTips,.weedControlTips,.vegetableGardeningTips, .animalGardeningTips, .winterGardeningTips]
    var body: some View {
        List(items, children: \.items) { row in
            Text(row.tip)
        }
            
        }
    }
