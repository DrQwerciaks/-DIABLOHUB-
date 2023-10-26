var notifications = 0, playerCoins = 0
var playerInventory = [];
let canUse = true, canClose = true
let staraTablica = "";
let code = 0

//mio///
let inventory = {}
let coins = 0
let currentOpenCase = null
let currentOpenCaseNumber = null

let intervalStart = false

let shuffluje = false
let shuffluje2 = false

let CreateShop = [
    {
        item: "skrzynia7",
        type: 'case',
        nowosc: true,
        name:  'Skrzynia',
        nametwo:  'NEED',
        visible: true,
        cost:  500,
        image: 'https://cdn.discordapp.com/attachments/794695986269257758/1068439004510429265/skrzynia7.png',
        items: [
            ['Gotówka', 'darkturquoise', 'money'],
            ['Bandaże', 'darkturquoise', 'bandage'],
            ['Radio', 'darkturquoise', 'radio'],
            ['Naprawka', 'darkturquoise', 'fixkit'],
            ['Lina', 'darkturquoise', 'rope'],

            ['Gotówka', 'deeppink', 'money'],
            ['Apteczka', 'deeppink', 'medikit'],
            ['Ammo 9mm', 'deeppink', 'ammo-9'],
            ['Scyzoryk', 'deeppink', 'weapon_switchblade'],
            ['Toporek', 'deeppink', 'weapon_battleaxe'],
            ['Kod Rabatowy 20%', 'deeppink', 'bon'],

            ['Gotówka', 'purple', 'money'],
            ['Amunicja 9mm', 'purple', 'ammo-9'],
            ['Kajdanki', 'purple', 'handcuffs'],

            ['Gotówka', 'red', 'money'],
            ['Tazer', 'red', 'weapon_stungun'],
            ['Pistolet', 'red', 'weapon_pistol'],
            ['Pistolet Vintage', 'red', 'weapon_vintagepistol'],
            ['Pistolet Bojowy', 'red', 'weapon_combatpistol'],

            ['Audi RS7', 'gold', 'carkey'],
            ['Mercedes AMG GT63', 'gold', 'carkey'],
            ['BMW M2F22', 'gold', 'carkey']
        ],
        amount: 0
    },

    {
        item: "skrzynia2",
        type: 'case',
        nowosc: false,
        name:  'Skrzynia',
        nametwo:  'Diablo',
        visible: true,
        cost:  150,
        image: 'https://cdn.discordapp.com/attachments/794695986269257758/1068433457241399316/IMG_8640.png',
        items: [
            ['Gotówka', 'darkturquoise', 'money'],
            ['Bandaże', 'darkturquoise', 'bandage'],
            ['Radio', 'darkturquoise', 'radio'],
            ['Naprawka', 'darkturquoise', 'fixkit'],
            ['Lina', 'darkturquoise', 'rope'],

            ['Gotówka', 'deeppink', 'money'],
            ['Ammo 9mm', 'deeppink', 'ammo-9'],
            ['Scyzoryk', 'deeppink', 'weapon_switchblade'],
            ['Toporek', 'deeppink', 'weapon_battleaxe'],

            ['Gotówka', 'purple', 'money'],
            ['Amunicja 9mm', 'purple', 'ammo-9'],
            ['Kajdanki', 'purple', 'handcuffs'],

            ['Gotówka', 'red', 'money'],
            ['Tazer', 'red', 'weapon_stungun'],
            ['Pistolet', 'red', 'weapon_pistol'],

            ['Pistolet Vintage', 'gold', 'weapon_vintagepistol'],
            ['Komoda', 'gold', 'carkey'],
            ['Zentorno', 'gold', 'carkey']
        ],
        amount: 0
    },
    {
        item: "kartasim",
        type: 'another',
        nowosc: false,
        name:  'Customowy',
        nametwo:  'Numer',
        visible: true,
        cost:  200,
        image: 'https://cdn.discordapp.com/attachments/1033344641032007752/1038041924357066824/Bez_tytuu.png',
        amount: 0
    },
    {
        item: "tablica",
        type: 'another',
        nowosc: false,
        name:  'Customowa',
        nametwo:  'Tablica',
        visible: true,
        cost:  200,
        image: 'https://cdn.discordapp.com/attachments/1033344641032007752/1040654226306633818/Bez_tytuusphotoshop.png',
        amount: 0
    },
    //casedaily ma byc zawsze na koncu
    {
        item: "casedaily",
        type: 'case',
        nowosc: false,
        name:  'Skrzynia',
        nametwo:  'Dzienna',
        visible: false,
        cost:  0,
        image: 'https://cdn.discordapp.com/attachments/794695986269257758/1068436197040472125/IMG_8640.png',
        items: [
            ['Gotówka', 'darkturquoise', 'money'],
            ['Gotówka', 'purple', 'money'],
            ['Gotówka', 'red', 'money'],
            ['Kod Rabatowy 20%', 'gold', 'bon']
        ],
        amount: 0
    },
]

const updateCoins = (coins) => {
    $(".coins-amount > .text").html(coins)
}

const updateinv = (inv) => {
    inv.forEach((data) => {
        CreateShop.forEach((data2, index) => {
            if (data.item == data2.item) {
                CreateShop[index].amount = data.amount
            }
        })

        if (currentOpenCase == data.item) {
            document.getElementById('amoumt').innerHTML = data.amount
            if (data.amount == 0) {
                document.querySelector(".btn-open").classList.add("niemozna");
            } else if (data.amount > 0)  {
                document.querySelector(".btn-open").classList.remove("niemozna");
            }
        }
    })
}

const getDaily = () => {
    $.post('https://diablohub_itemshop/buyItem', JSON.stringify({
        item: 'casedaily',
        ilosc: 1
    }), function(data){
        updateCoins(data.coins)
        updateinv(data.inventory)
    });
}

window.addEventListener("message", function(event) {
    switch (event.data.action) {
        case "openShop":
            updateCoins(event.data.data.coins)
            updateinv(event.data.data.inventory)
            if(event.data.data.timeformat <= 0){
                document.getElementById('time').innerHTML = "Twoja skrzynka czeka na odbiór!";
                document.querySelector('.buy-btn1').classList.remove('niemozna')
            }else{
                document.getElementById('time').innerHTML = "Możesz odebrać skrzynkę za: " + event.data.data.timeformat + " godzin/y";
                document.querySelector('.buy-btn1').classList.add('niemozna')
            }
            this.document.getElementById('container').style.display = 'flex'
            break;
        case "toggle":
            updateinv(event.data.playerInfo.inventory);
            updateCoins(event.data.playerInfo.coins);
            app.toggleView(event.data.data, event.data.data2, event.data.count);
            break;
    }
})

window.onkeydown = function(event) {
    if (event.keyCode == 27) {
        if (!shuffluje){
            document.getElementById('container').style.display = 'none'
            cancel()
            $.post('https://diablohub_itemshop/zamknij', JSON.stringify({}));
        }
    }
};

///mio///
    //Funkcje
    CreateShop.forEach((var1) => {
        if(var1.visible){
            let createDiv = document.createElement('div')
            createDiv.classList.add("case")
            createDiv.innerHTML = `
            <div class="case-left">
                <div class="case-title">
                    <div class="case-title-p">${var1.name}</div>
                    <div class="case-title-name">${var1.nametwo}</div>
                </div>
                <div class="case-cost">
                    <img src="images/coin.png">
                    <span class="text">${var1.cost}</span>
                </div>
            </div>
            <div class='nowosc' `+ (var1.nowosc && "style='display:flex'" || "style='display:none'") +`>Nowość</div>
            <div class="case-right">
                <img src=${var1.image} alt="">
            </div>`

            if(var1.type == 'case'){
                document.getElementById('cases').appendChild(createDiv)
            }else{
                document.getElementById('casestwo').appendChild(createDiv)
            }
        }
    })

    const OpenCase = (casenumber) => {
        let items = document.getElementById('items').innerHTML = ``
        let currentValue = document.getElementById('case-item').value
        let btns = document.querySelectorAll('.btn')


        for(let i = 0; i < btns.length; i++){
            let btn = btns[i]
            btn.onclick = function(){
                if(btn.innerHTML == '+' && currentValue > 0 && currentValue < 10){
                    currentValue++
                    document.getElementById('case-item').value = currentValue
                }else if(btn.innerHTML == '-' && currentValue > 1){
                    currentValue--
                    document.getElementById('case-item').value = currentValue
                }
                document.getElementById('coins-amount').innerHTML = CreateShop[casenumber].cost * currentValue
            }
        }

        if(CreateShop[casenumber].amount == 0){
            document.querySelector(".btn-open").classList.add("niemozna");
        }else{
            document.querySelector(".btn-open").classList.remove("niemozna");
        }

        document.getElementById('amoumt').innerHTML = CreateShop[casenumber].amount

        document.getElementById('shop').style.display = 'none'
        document.getElementById('buyitem').style.display = 'flex'

        document.getElementById('buyitem-image').src = CreateShop[casenumber].image
        document.getElementById('case-name').innerHTML = CreateShop[casenumber].nametwo
        document.getElementById('coins-amount').innerHTML = CreateShop[casenumber].cost

        if(CreateShop[casenumber].item == 'tablica' || CreateShop[casenumber].item == 'kartasim'){
            document.getElementById('openes').innerHTML = 'Użyj'
            document.getElementById('buy-btnsss').style.display = 'flex'
            document.getElementById('buy-inp').style.display = 'flex'
            document.getElementById('buy-btnsss1').style.display = 'none'
        }else if(CreateShop[casenumber].item == 'casedaily'){
            document.getElementById('buy-inp').style.display = 'none'
            document.getElementById('buy-btnsss').style.display = 'none'
            document.getElementById('buy-btnsss1').style.display = 'flex'
        }else{
            document.getElementById('buy-btnsss1').style.display = 'none'
            document.getElementById('buy-inp').style.display = 'flex'
            document.getElementById('buy-btnsss').style.display = 'flex'
            document.getElementById('openes').innerHTML = 'Otwórz'
        }

        if(CreateShop[casenumber].items != undefined){
            CreateShop[casenumber].items.forEach(items => {
                let createItem = document.createElement('div')
                createItem.classList.add("item")
                document.getElementById('title-p').innerHTML = CreateShop[casenumber].name
                createItem.innerHTML = `
                <img src='https://cfx-nui-ox_inventory/web/images/${items[2]}.png' style="filter: drop-shadow(0 0 1rem ${items[1]});">
                <div class="title" style="border-bottom: 5px solid ${items[1]}; ">${items[0]}</div>
                `
                
                document.getElementById('items').appendChild(createItem)
            });
            document.getElementById('items').style.display = "grid"
            document.getElementById('bottom').style.bottom = "0"
            document.getElementById('title-desc').innerHTML = `Przedmioty które możesz wylosować w tej skrzyni`
        }else{
            document.getElementById('title-p').innerHTML = CreateShop[casenumber].name
            document.getElementById('bottom').style.bottom = "55vh"
            document.getElementById('items').style.display = 'none'
            document.getElementById('title-desc').innerHTML = ``
        }

        currentOpenCase = CreateShop[casenumber].item
        currentOpenCaseNumber = casenumber
        
    }

    const openMenu = (menu) => {
        if(menu == 'sklep'){
            document.querySelector('.button#sklep').classList.add('selected')
            document.querySelector('.button#info1').classList.remove('selected')
            document.getElementById('buyitem').style.display = 'none'
            document.getElementById('shop').style.display = 'flex'
            document.getElementById('info').style.display = 'none'
        }else if(menu == 'info1'){
            document.querySelector('.button#sklep').classList.remove('selected')
            document.querySelector('.button#info1').classList.add('selected')
            document.getElementById('buyitem').style.display = 'none'
            document.getElementById('shop').style.display = 'none'
            document.getElementById('info').style.display = 'flex'
        }
    }

    document.getElementById('openes').onclick = function(){
        if (CreateShop[currentOpenCaseNumber].amount > 0 && !shuffluje2) {
            shuffluje2 = true
            document.getElementById('right').style.opacity = '0';
            setTimeout(() => {
                document.getElementById('right').style.display = 'none';
                document.getElementById('left').style = 'width: 100%;'
                document.getElementById('buyitem-image').style.transform = 'scale(1.3)';
                setTimeout(() => {
                    useItem(currentOpenCase)
                }, 650)
            }, 550);
        }
    }

    let mas = document.querySelectorAll('.baner-btn-new')
    for(let i = 0; i < mas.length; i++){
        let btn = mas[i]
        btn.onclick = function(){
            OpenCase(CreateShop.findIndex((element) => element.item == 'mas'+i))
        }
    }

    document.querySelector('.baner-btn').onclick = function(){
        OpenCase(CreateShop.findIndex((element) => element.item == 'casedaily'))
    }

    // const uzyjtab = () => {
    //     if(currentOpenCase == 'tablica'){
    //         let tablica = document.getElementById('inputText').value
    //         $.post('https://wait_coinsystem/tablica', JSON.stringify({tab: tablica}));  
    //     }
    // }

    const cancel = () => {
        document.getElementById('labelleft').style.display = 'none'
        document.getElementById('inputText').style.display = 'none'
        document.getElementById('inputText1').style.display = 'none'
        document.getElementById('btnss').style.display = 'none'
        document.getElementById('right').style.display = 'block';
        document.getElementById('left').style = 'width: 30%;'
        document.getElementById('acceeept').style.display = 'flex'
        document.getElementById('acceeept1').style.display = 'none'
        document.getElementById('inputText1').value = ''
        document.getElementById('labelleft').innerHTML = ''
        document.getElementById('buyitem-image').style.transform = 'scale(1.0)';
        setTimeout(function(){
            document.getElementById('right').style.opacity = '1';
        }, 550)
    }

    const uzyj = () => {
        if(currentOpenCase == 'tablica'){

            let tablica = document.getElementById('inputText').value
            staraTablica = tablica
            fetch(`https://${GetParentResourceName()}/getItemInfo`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    tab: tablica,
                    newTab: tablica
                })
            }).then(resp => resp.json()).then(resp => {
                if(resp == 'owner'){
                    document.getElementById('inputText').value = ''
                    document.getElementById('labelleft').innerHTML = 'Wprowadz nową rejestracje pojazdu'
                    document.getElementById('acceeept').style.display = 'none'
                    document.getElementById('acceeept1').style.display = 'flex'
                }else{
                    document.getElementById('error').style.display = 'block'
                    document.getElementById('error').innerHTML = resp
                    setTimeout(() => {
                        document.getElementById('error').style.display = 'none'
                    }, 10000);
                }
            });

        }else if(currentOpenCase == 'kartasim'){
            let nrTel = document.getElementById('inputText1').value
            $.post('https://diablohub_itemshop/changePhone', JSON.stringify({
            newNumber: nrTel
        }), function(data){
            if (data == 'success'){
                document.getElementById('labelleft').style.display = 'none'
                document.getElementById('inputText1').style.display = 'none'
                document.getElementById('btnss').style.display = 'none'
                document.getElementById('right').style.display = 'block';
                document.getElementById('left').style = 'width: 30%;'
                document.getElementById('acceeept').style.display = 'flex'
                document.getElementById('acceeept1').style.display = 'none'
                document.getElementById('inputText1').value = ''
                document.getElementById('labelleft').innerHTML = ''
                document.getElementById('buyitem-image').style.transform = 'scale(1.0)';
                let array = CreateShop.find(element => element.item == 'kartasim')
                let currentAmount = array.amount
                array.amount = currentAmount - 1
                document.getElementById('amoumt').innerHTML = array.amount
                if(array.amount == 0){
                    document.querySelector(".btn-open").classList.add("niemozna");
                }else{
                    document.querySelector(".btn-open").classList.remove("niemozna");
                }
                setTimeout(function(){
                    document.getElementById('right').style.opacity = '1';
                }, 550)
            }else{
                document.getElementById('error').style.display = 'block'
                document.getElementById('error').innerHTML = data
                setTimeout(() => {
                    document.getElementById('error').style.display = 'none'
                }, 10000);
            }        
        });
        }
    }

    const changerej = () => {
            let tablica = document.getElementById('inputText').value
            if(tablica.length == 8){
                fetch(`https://${GetParentResourceName()}/changerejka`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    tabka: tablica
                })
                }).then(resp => resp.json()).then(resp => {
                    if(resp == 'zmieniono'){
                        document.getElementById('labelleft').style.display = 'none'
                        document.getElementById('inputText').style.display = 'none'
                        document.getElementById('btnss').style.display = 'none'
                        document.getElementById('right').style.display = 'block';
                        document.getElementById('left').style = 'width: 30%;'
                        document.getElementById('acceeept').style.display = 'flex'
                        document.getElementById('acceeept1').style.display = 'none'
                        document.getElementById('inputText').value = ''
                        document.getElementById('labelleft').innerHTML = 'Wprowadz starą rejestracje pojazdu'
                        document.getElementById('buyitem-image').style.transform = 'scale(1.0)';
                        let arrayse = CreateShop.find(element => element.item == 'tablica')
                        let currentAmount = arrayse.amount
                        arrayse.amount = currentAmount - 1
                        document.getElementById('amoumt').innerHTML = arrayse.amount
                        if(arrayse.amount == 0){
                            document.querySelector(".btn-open").classList.add("niemozna");
                        }else{
                            document.querySelector(".btn-open").classList.remove("niemozna");
                        }
                        setTimeout(function(){
                            document.getElementById('right').style.opacity = '1';
                        }, 550)
                    }else{
                        document.getElementById('error').style.display = 'block'
                        document.getElementById('error').innerHTML = resp
                        setTimeout(() => {
                            document.getElementById('error').style.display = 'none'
                        }, 10000);
                    }
                });
            }else{
                document.getElementById('error').style.display = 'block'
                document.getElementById('error').innerHTML = "Rejestracja musi posiadać 8 znaków"
                setTimeout(() => {
                    document.getElementById('error').style.display = 'none'
                }, 10000);
            }
    }

    //Petle

    let cases = document.querySelectorAll('.case')
    for(let i = 0; i < cases.length; i++){
        let caseu = cases[i]
        caseu.onclick = function(){
            OpenCase(i)
        }
    }
    

    let buttons = document.querySelectorAll('.button')
    for(let i = 0; i < buttons.length; i++){
        let button = buttons[i]
        button.onclick = function(){
            let menu = document.getElementsByClassName('button')[i].id
            openMenu(menu)
        }
    }

    let buyItem = function(){
        $.post('https://diablohub_itemshop/buyItem', JSON.stringify({
            item: currentOpenCase,
            ilosc: Number($("#case-item").val())
        }), function(data){
            updateCoins(data.coins)
            updateinv(data.inventory)
        });
    }

///mio///


function useItem(item) {
    if (item == 'tablica') {
        document.getElementById('inputText').style.display = 'flex'
        document.getElementById('btnss').style.display = 'flex'
        document.getElementById('labelleft').style.display = 'block'
        document.getElementById('labelleft').innerHTML = "Wprowadz starą rejestracje pojazdu"
    } else if(item == 'kartasim') {
        document.getElementById('labelleft').innerHTML = "Wprowadź nowy numer telefonu"
        document.getElementById('inputText1').style.display = 'flex'
        document.getElementById('btnss').style.display = 'flex'
        document.getElementById('labelleft').style.display = 'block'
    } else {
        //playerInventory['' + item + ''] = playerInventory['' + item + ''] - 1
        $.post('https://diablohub_itemshop/useItem', JSON.stringify({
            item: item
        }));
    }
    //createInventory()
    //canUse = false
    setTimeout(() => {
        shuffluje2 = false
        canUse = true
    }, 1000);
}

let wylosowal = false

///////////////////////////////////////////////////// SKRZYNKI /////////////////////////////////////////////////////
let mnoznik = 1
let wymianacoin = 0
const app = new Vue({
    el: '#app',
    data: {
        rolled: 0,
        items: [
            {name: 'vintage', desc: 'zabytkowy', color: 'red', img: 'img/vintage.png'},
            {name: 'vintage2', desc: 'zabytkowy', color: 'gold', img: 'img/vintage.png'},
            {name: 'vintage3', desc: 'zabytkowy', color: 'violet', img: 'img/vintage.png'},
            {name: 'vintage4', desc: 'zabytkowy', color: 'blue', img: 'img/vintage.png'}
        ],
        rolling: false,
        lastindex: 'index3',
        chest_name: 'GTR CASE',
        summary_display: 'flex',
        cases: 0,
        animDur: 8000,
        itemKey: null,
    },
    methods: {
        toggleView(items, itemKey, count) {
            if(items) {
                this.items = items
                for(let item of this.items) {
                    if(item.type == 'car'){
                        item.img = `https://cfx-nui-ox_inventory/web/images/carkey.png`
                    }else{
                        item.img = `https://cfx-nui-ox_inventory/web/images/${item.name}.png`
                    }
                }
            }
            this.count = count
            this.cases = 1
            this.itemKey = itemKey
            start()
            if(!this.rolling) {
                this.shuffle()
            }
            this.open()
        },
        close() {
            this.leave()
        },
        openCase(id) {
            this.shuffle()
            this.cases--
            this.rolled = id - 1
            let rolled = this.items[this.rolled]
            wymianacoin = this.count * this.items[this.rolled].wymianacoin
            mnoznik = this.count
            if (wymianacoin == undefined || wymianacoin <= 0 || isNaN(wymianacoin)){
                document.getElementById('zamien').style.display = 'none'
            }else{
                document.getElementById('zamien').style.display = 'flex'
                document.getElementById('ammmo').innerHTML = wymianacoin
            }
            let dist = Math.floor(Math.random() * (15060 - 14830) + 14780)
            document.querySelector('.case2-container').style.display = 'flex'
            document.getElementById('index65').className = 'case2 ' + rolled.color
            document.getElementById('index65').innerHTML = '<div class="case2-img"><img src="' + rolled.img + '"></div><div class="case2-bottom"><div class="case2-description"><div class="case2-desc">' + rolled.desc + '</div><div class="case2-title">' + rolled.label + '</div></div></div><div class="case2-sounder"></div>'
            this.rolling = true
            this.sound()
            this.$refs.items.animate([
                {left: '0px'},
                {left: '-' + dist + 'px'}
            ], {
                duration: this.animDur,
                easing: 'ease'
            })
            setTimeout(() => {
                this.$refs.items.style.left = '-' + dist + 'px'
                this.rolling = false
                this.summaryFade('in')
                document.querySelector('.case2-container').style.display = 'none'
                
                // $.post('https://wait_coinsystem/wylosowal', JSON.stringify({}));
                wylosowal = true
            }, this.animDur)
        },
        shuffle(){
            shuffluje = true
            this.$refs.items.innerHTML = ""
            for(i=0; i<100; i++){
                let randomitem = this.items[Math.floor(Math.random()*this.items.length)];
                let item = document.createElement("div");
                item.classList.add("case2", randomitem.color)
                item.setAttribute('id', 'index' + i)
                item.innerHTML = '<div class="case2-img"><img src="' + randomitem.img + '"></div><div class="case2-bottom"><div class="case2-description"><div class="case2-desc">' + randomitem.desc + '</div><div class="case2-title">' + randomitem.label + '</div></div></div><div class="case2-sounder"></div>'
                this.$refs.items.appendChild(item)
            }
        },
        open(){
            if(this.rolling == false && this.cases > 0){
                if (this.itemKey == null) {
                    return
                }
                this.openCase(this.itemKey)
                this.itemKey = null
            }
            else{
                this.$refs.btn.animate([
                    {left: '0px'},
                    {left: '-15px'},
                    {left: '15px'},
                    {left: '0px'}
                ], {
                    duration: 100
                })
            }
        },
        get(){
            app.close()
            if (wylosowal){
                wylosowal = false
                shuffluje = false
                $.post('https://diablohub_itemshop/wylosowal', JSON.stringify({mnoznik: mnoznik}));
            }
        },
        zamiencoin(){
            app.close()
            if (wylosowal){
                wylosowal = false
                shuffluje = false
                updateCoins(Number($(".coins-amount > .text").html()) + wymianacoin)
                $.post('https://diablohub_itemshop/wymiencoin', JSON.stringify({mnoznik: mnoznik}));
            }
        },
        checkCollision(elm1, elm2) {
            var elm1Rect = elm1.getBoundingClientRect();
            var elm2Rect = elm2.getBoundingClientRect();
          
            return (elm1Rect.right >= elm2Rect.left &&
                elm1Rect.left <= elm2Rect.right) &&
              (elm1Rect.bottom >= elm2Rect.top &&
                elm1Rect.top <= elm2Rect.bottom);
        },
        sound(){
            let audio = new Audio('sound.wav')
            if(this.rolling == true){
                setTimeout(() => {
                    for(let caseSounder of document.getElementsByClassName('case2')) {
                        if(this.checkCollision(caseSounder, document.getElementById('arrow'))) {
                            if(caseSounder.id !== this.lastindex){
                                this.lastindex = caseSounder.id
                                audio.play();
                            }
                        }
                    }
                    this.sound()
                }, 70)
            }
        },
        summaryFade(type){
            let summary = document.getElementById('summary')
            switch(type){
                case 'in':
                    this.summary_display = 'flex'
                    summary.style.opacity = '0'
                    summary.animate([
                        {opacity: 0},
                        {opacity: 1},
                        ], {
                            duration: 200
                        }
                    )
                    setTimeout(function(){
                        summary.style.opacity = '1'
                    }, 200)
                    break
                case 'out':
                    this.$refs.items.style.left = '0px'
                    summary.style.opacity = '1'
                    summary.animate([
                        {opacity: 1},
                        {opacity: 0},
                        ], {
                            duration: 200
                        }
                    )
                    setTimeout(() => {
                        summary.style.opacity = '0'
                        this.summary_display = 'none'
                    }, 200)
                    break
            }
        },
        leave(){
            document.querySelector(".container-2").style.opacity = '1'
            document.querySelector(".container-2").animate([
                {opacity: 1},
                {opacity: 0},
                ], {
                    duration: 200
                }
            )
            setTimeout(function(){
                document.querySelector(".container-2").style.opacity = '0'
                document.querySelector(".container-2").style.display = 'none'
                document.getElementById('right').style.display = 'block';
                document.getElementById('left').style = 'width: 30%;'
                document.getElementById('buyitem-image').style.transform = 'scale(1.0)';
                setTimeout(function(){
                    document.getElementById('right').style.opacity = '1';
                }, 550)
            }, 200)
        }
    }
})

function start(){
    document.querySelector(".container-2").style.display = 'block'
    document.querySelector(".container-2").style.opacity = '0'
    document.querySelector(".container-2").animate([
        {opacity: 0},
        {opacity: 1},
        ], {
            duration: 200
        }
    )
    setTimeout(function(){
        document.querySelector(".container-2").style.opacity = '1'
    }, 200)
    app.summary_display = 'none'
}


app.close()