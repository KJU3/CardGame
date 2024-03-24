<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>카드게임</title>
        <style>
            /* 초기화 */

            * {
                margin: 0;
                padding: 0;
            }

            body {
                font-family: sans-serif;
            }

            li {
                list-style: none;
            }
            a {
                text-decoration: none;
            }
            img {
                border: 0;
            }

            #main_header {
                width: 960;
                margin: 0 auto;

                height: 160px;
                position: relative;
            }

            #content {
                width: 960px;
                margin: 0 auto;
                overflow: hidden;
            }

            #content > #main_section {
                width: 750px;
                float: left;
            }
            #content > #main_aside {
                width: 200px;
                float: right;
            }

            #gameTable img {
                max-width: 70px;
                width: auto;
                height: auto;
            }

            #buttons button {
                visibility: hidden;
            }
        </style>
    </head>
    <body>
        <!-- UI 구성 -->
        <header id="main_header">
            <div id="title">
                <h1>카드 게임</h1>
            </div>

            <nav id="main_form">
                <!-- 입력 레이아웃 -->
                <form id="inputForm">
                    <input type="text" id="inputText" placeholder="이름을 입력하세요." required />
                    <input type="button" id="inputButton" value="입력" />
                </form>
            </nav>

            <nav id="main_btn">
                <div id="buttons">
                    <button id="startGame">StartGame</button>
                    <button id="endGame">EndGame</button>
                    <button id="frontButton">전체 보이기</button>
                    <button id="backButton">전체 숨기기</button>
                </div>
            </nav>
        </header>

        <div id="content">
            <section id="main_section">
                <!-- 게임진행 레이아웃 -->
                <div id="gameLayout">
                    <!-- <div id="infoTable"></div> -->
                    <div id="gameTable"></div>
                </div>
            </section>
            <aside id="main_aside">
                <div id="rankBoard"></div>
            </aside>
        </div>

        <script>
            window.onload = function () {
                // 게임 시작
                // dealer.gameStart();
                // 딜러 : 게임을 진행하는 호스트
                // 게임을 진행하는 진행자.
                // 담당 테이블이 있다.
                // 점수와 랭킹을 기록할 랭크보드를 하나 가진다.
                // 카드 덱을 하나 가진다.
                // 손님 1명을 받는다.
                class Dealer {
                    constructor(gameTable, rankBoard, deck) {
                        this.setGameTable(gameTable);
                        this.setRankBoard(rankBoard);
                        this.setDeck(deck);
                    }

                    test() {
                        console.log(this);
                    }
                    // 손님 1명을 받는다.
                    firstGuest;
                    setGuest(firstGuest) {
                        this.firstGuest = firstGuest;
                    }

                    // 덱을 하나 가진다.
                    deck;
                    setDeck(deck) {
                        this.deck = deck;
                    }

                    // 테이블의 카드를 섞어서 다시 셋팅
                    shuffleDeckOfTable() {
                        let deck = this.deck;
                        deck.sort(function () {
                            return Math.random() - 0.5;
                        });
                        this.tableSetting();
                    }

                    // 테이블의 카드를 정렬해서 다시 셋팅
                    sortDeckOfTable() {
                        let deck = this.deck;
                        deck.sort(function (a, b) {
                            return a.id - b.id;
                        });
                        this.tableSetting();
                    }

                    // 카드를 뒤집는 함수
                    flip(e) {
                        let card = e;
                        if (e instanceof PointerEvent) {
                            card = e.target;
                        }

                        if (this.isFront(card)) {
                            this.backFlip(card);
                        } else {
                            this.frontFlip(card);
                        }
                    }

                    // 카드가 앞면인지 확인하는 함수
                    isFront(card) {
                        return card.state === 'front';
                    }

                    // 카드를 뒤로 뒤집는 함수
                    backFlip(card) {
                        card.src = card.backImg;
                        card.state = 'back';
                    }

                    // 카드를 앞으로 뒤집는 함수
                    frontFlip(card) {
                        card.src = card.frontImg;
                        card.state = 'front';
                    }

                    // 테이블의 모든 카드를 뒤로 뒤집는 함수
                    backFlipAllCard() {
                        for (let i = 0; i < 52; i++) {
                            this.backFlip(this.deck[i]);
                        }
                    }

                    // 테이블의 모든 카드를 앞으로 뒤집는 함수
                    frontFlipAllCard() {
                        for (let i = 0; i < 52; i++) {
                            this.frontFlip(this.deck[i]);
                        }
                    }

                    // 테이블을 하나 맡는다.
                    gameTable;
                    setGameTable(gameTable) {
                        this.gameTable = gameTable;
                    }

                    // 테이블에 52장의 카드를 셋팅하는 함수
                    tableSetting() {
                        let deck = this.deck;
                        for (let i = 0; i < deck.length; i++) {
                            gameTable.appendChild(deck[i]);
                        }
                    }

                    // 테이블을 치우는 함수
                    tableClear() {
                        // 노드 삭제 정상적으로 되는지 테스트 필요
                        gameTable.innerHTML = '';
                    }

                    // 랭킹 보드를 하나 가진다.
                    rankBoard;
                    setRankBoard(rankBoard) {
                        this.rankBoard = rankBoard;
                    }

                    // // 게임이 시작하면 시간 카운트
                    // startCount(){
                    //     // 함수가 호출되면 1분에서 0초까지 카운트한다.
                    //     setTimeout(dummy, 1000)
                    //     set

                    // }

                    // dummy(){}

                    // 게임을 시작하는 함수
                    // 모든 셋팅이 끝나고 손님이 오면
                    // 게임을 시작한다.
                    gameStart() {
                        // // 카드를 섞어서 뒤집힌 상태로 테이블에 셋팅한다.
                        this.shuffleDeckOfTable();
                        // // 5초 동안 앞면을 보여준다.
                        setTimeout(this.hintFiveSecend.bind(this), 1000);
                        // // 5번의 생명을 부여받는다.
                        this.life = 5;
                        this.score = 0;
                        // // 손님이 카드 2개를 고른다.
                        // // 맞으면 1점
                        // // 틀리면 생명 -1
                        // // 생명이 0이 되면 게임이 끝난다.
                    }

                    // main 함수가 있다고 가정
                    // 게임이 시작된다.
                    // 5의 생명을 받는다.
                    // 카드를 섞고 5초 동안 앞면을 보여준다.
                    // gameStart();
                    // 반복문으로 생염이 0이 되는지 판단.
                    // 만약 기회가 전부 소진되면 반복문 종료
                    // while (true) {
                    //     if(dealer.life === 0){
                    //         gameEnd();
                    //         return;
                    //     }
                    // }

                    // 게임이 끝나면
                    gameEnd() {
                        // 사용자 이름과 점수를 저장한다.
                        let guestName = this.firstGuest.getName();
                        let score = this.score;
                        this.saveNameAndScore(guestName, score);
                        // 화면에 이름과 점수를 보여준다.
                        this.printScore(guestName);
                        // 랭크보드를 업데이트한다.
                        this.updateRankboard();
                    }

                    // 손님의 이름과 점수를 저장하는 함수
                    saveNameAndScore(name, score = 0) {
                        this.rankBoard.setGuestAndScore(name, score);
                    }

                    // 게임이 끝나면 본인의 점수를 알려주는 함수
                    printScore(name) {
                        let score = this.rankBoard.getGuestScore(name);
                        alert(`당신의 점수는${score}점 입니다.`);
                    }

                    // 랭킹보드를 업데이트하는 함수
                    updateRankboard() {
                        let rankArr = this.rankingUpdate();
                        let str = '<ol>';
                        for (let i of rankArr) {
                            str += `<li>${rankArr.indexOf(i) + 1}위. 이름 : ${i[0]}\t\t점수 : ${i[1]} </li>`;
                        }
                        str += '</ol>';
                        rankBoard.innerHTML = str;
                    }

                    // 랭킹을 갱신하는 함수
                    rankingUpdate() {
                        let rankArr = [];
                        let rankEntry = this.rankBoard.getAllGuestAndScore();
                        for (let i of rankEntry) {
                            rankArr.push(i);
                        }
                        rankArr.sort(function (a, b) {
                            return b[1] - a[1];
                        });
                        return rankArr;
                    }

                    // 5초동안 앞면을 보여준다.
                    hintFiveSecend() {
                        this.frontFlipAllCard();
                        setTimeout(this.backFlipAllCard.bind(this), 5000);
                    }

                    life;
                    firstCard;
                    score;
                    // 손님이 카드 두개를 선택해서 같으면 카드 두개 반환
                    pickTwoCard(e) {
                        let card = e;
                        if (e instanceof PointerEvent) {
                            card = e.target;
                        }
                        // 카드가 앞면이거나, 생명이 다하면 카드를 고르지 못한다.
                        if (this.isFront(card) || this.life <= 0) return;
                        // 카드가 두개 선택 되었으면 카드를 비교한다.
                        let selectedFirstCard;
                        if (!this.firstCard) {
                            this.flip(card);
                            this.firstCard = card;
                        } else {
                            // 첫번째 카드를 선택했는가
                            selectedFirstCard = true;
                        }

                        // 두번째 카드가 선택되었을때
                        if (selectedFirstCard) {
                            // 두번째 카드를 뒤집는다.
                            this.flip(card);
                            // 첫번째 카드와 두번째 카드가 같은지 비교.
                            if (this.compareTwoCard(this.firstCard, card)) {
                                // 같으면 놔둔다.
                                this.firstCard = 0;
                                this.score++;
                                return;
                            } else {
                                // 다르면 둘다 뒷면으로 뒤집는다.
                                // 생명을 1 차감한다.
                                setTimeout(this.flip.bind(this), 1000, this.firstCard);
                                setTimeout(this.flip.bind(this), 1000, card);
                                this.firstCard = 0;
                                this.life--;
                            }
                        }
                    }

                    // 두 카드가 같은지 비교하는 함수
                    compareTwoCard(one, two) {
                        return one.class === two.class;
                    }
                }

                // 랭킹 보드 클래스
                // 손님의 이름과 점수를 저장한다.
                class RankBoard {
                    // 손님 이름 : 점수
                    // Map으로 관리
                    rankBoard = new Map();

                    // 손님과 점수를 map에 저장하는 함수
                    setGuestAndScore(guest, score) {
                        this.rankBoard.set(guest, score);
                    }

                    getAllGuestAndScore() {
                        return this.rankBoard.entries();
                    }

                    // 손님의 이름으로 손님의 점수를 반환하는 함수
                    getGuestScore(guest) {
                        return this.rankBoard.get(guest);
                    }
                }

                // 손님 클래스
                class Guest {
                    name;

                    constructor(name) {
                        this.name = name;
                    }

                    getName() {
                        return this.name;
                    }
                }

                class Table {
                    // 초기 테이블은 고정
                    name;
                    gameTable = document.getElementById('gameTable');

                    constructor(name) {
                        this.name = name;
                    }

                    // 새로운 테이블을 설정하는 함수.
                    getGameTable() {
                        return this.gameTable;
                    }

                    getName() {
                        return this.name;
                    }

                    print() {
                        return 'test';
                    }
                }

                // 덱 클래스
                class Deck {
                    // 객체 생성시 52장의 카드를 가진다.
                    deck;
                    constructor() {
                        this.deck = this.makeDeck();
                    }

                    // 52장의 카드를 가진 덱을 만드는 함수
                    makeDeck() {
                        let deckArr = [];
                        for (let num = 0; num < 52; num++) {
                            // 이미지 객체 생성
                            let card = document.createElement('img');
                            // 카드 고유 번호
                            card.id = num + 1;
                            // 카드 번호
                            card.num = `${(num % 13) + 1}`;
                            // 카드 색깔
                            card.color = Math.floor(num / 13) % 2 == 0 ? 'red' : 'black';
                            // 카드 클래스
                            card.class = `${(num % 13) + 1} ${card.color}`;
                            // 카드 앞면
                            card.frontImg = `card_img/${num}.png`;
                            // 카드 뒷면
                            card.backImg = 'card_img/back.png';
                            // 현재 카드가 보이는 면
                            card.src = card.backImg;
                            // 카드의 상태
                            card.state = 'back';
                            deckArr.push(card);
                        }
                        return deckArr;
                    }
                }

                // 참조 얻기
                let inputForm = document.getElementById('inputForm');
                let inputText = document.getElementById('inputText');
                let inputButton = document.getElementById('inputButton');
                let gameTable = document.getElementById('gameTable');
                let rankBoard = document.getElementById('rankBoard');

                let startGame = document.getElementById('startGame');
                let endGame = document.getElementById('endGame');
                let frontButton = document.getElementById('frontButton');
                let backButton = document.getElementById('backButton');

                // 딜러생성 : 테이블, 랭크보드, 덱을 할당
                let dealer = new Dealer(gameTable, new RankBoard(), new Deck().deck);

                inputButton.addEventListener('click', function () {
                    if (!inputText.value) {
                        alert('이름을 입력하세요.');
                        return;
                    }
                    dealer.setGuest(new Guest(inputText.value));
                    startGame.style.visibility = 'visible';
                    endGame.style.visibility = 'visible';
                    frontButton.style.visibility = 'visible';
                    backButton.style.visibility = 'visible';
                    inputForm.style.visibility = 'hidden';
                });

                gameTable.addEventListener('click', dealer.pickTwoCard.bind(dealer));

                startGame.addEventListener('click', dealer.gameStart.bind(dealer));
                endGame.addEventListener('click', dealer.gameEnd.bind(dealer));
                endGame.addEventListener('click', function () {
                    inputForm.style.visibility = 'visible';
                });
                frontButton.addEventListener('click', dealer.frontFlipAllCard.bind(dealer));
                backButton.addEventListener('click', dealer.backFlipAllCard.bind(dealer));

                dealer.rankBoard.setGuestAndScore('뾰로롱', 3);
                dealer.rankBoard.setGuestAndScore('김자바', 15);
                dealer.rankBoard.setGuestAndScore('나자스', 5);
                dealer.rankBoard.setGuestAndScore('지져스', 13);
            };
        </script>
    </body>
</html>
