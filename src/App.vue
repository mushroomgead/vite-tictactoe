<script setup lang="ts">
import { ref } from 'vue';
import Tile from './components/Tile.vue'

const audioClick = new Audio("/sounds/mixkit-handgun-click.mp3")
const audioCongrat = new Audio("/sounds/mixkit-cartoon-laugh-voice.wav")

enum Player {
  X = "X",
  O = "O"
}

let tiles = ref<string[]>([])
let winner = ref<string>("")
let winnerCssClass = ref<string>("")
let playerTurn = ref<Player>(Player.X)

const winningCombination = [
  // Rows
  { combo: [1, 2, 3], winnerClass: "strike-row-1" },
  { combo: [4, 5, 6], winnerClass: "strike-row-2" },
  { combo: [7, 8, 9], winnerClass: "strike-row-3" },
  // Columns
  { combo: [1, 4, 7], winnerClass: "strike-col-1" },
  { combo: [2, 5, 8], winnerClass: "strike-col-2" },
  { combo: [3, 6, 9], winnerClass: "strike-col-3" },
  // Diagonals
  { combo: [1, 5, 9], winnerClass: "strike-diagonals-1" },
  { combo: [3, 5, 7], winnerClass: "strike-diagonals-2" },
]

function onTap(index: number) {

  const hadWinner = winner.value
  if (!tiles.value[index] && !hadWinner) {
    audioClick.play()
    tiles.value[index] = playerTurn.value
    playerTurn.value = playerTurn.value === Player.X ? Player.O : Player.X
    onCheckWinner()
  }
}

function onCheckWinner() {

  const tileValues = tiles.value
  for (const { combo, winnerClass } of winningCombination) {
    const firstPos = tileValues[combo[0]]
    const secondPos = tileValues[combo[1]]
    const thirdPos = tileValues[combo[2]]

    if (firstPos !== undefined && firstPos === secondPos && firstPos === thirdPos) {
      audioCongrat.play()
      if (firstPos === Player.X) {
        winner.value = Player.X
        winnerCssClass.value = winnerClass
      } else {
        winner.value = Player.O
      }
      return
    }
  }
}

function resetTiles() {
  tiles.value = []
  winner.value = ""
  playerTurn.value = Player.X
  winnerCssClass.value = ""
}

</script>

<template>
  <div class="container">
    <div class="container-game">
      <Tile v-for="i in 9" :index="i" :title='tiles[i] ?? ""' :onTap="onTap" />
      <div :class="['line', winnerCssClass]"></div>
    </div>
    <button class="btn-reset" @click="resetTiles">NEW GAME</button>
  </div>
</template>

<style scoped>
.container {
  position: relative;
  background-color: #2B0040;
  padding: 60px;
  border-radius: 20px;
}

.btn-reset {
  background-color: white;
  color: #000000;
  font-weight: 900;
  width: 300px;
  padding: 14px;
}

.line {
  position: absolute;
}

.strike-col-1 {
  width: 5px;
  height: 430px;
  background-color: aquamarine;
  top: 0;
  left: 60px;
}

.strike-col-2 {
  width: 5px;
  height: 430px;
  background-color: aquamarine;
  top: 0;
  left: calc(403px / 2);
}

.strike-col-3 {
  width: 5px;
  height: 430px;
  background-color: aquamarine;
  top: 0;
  left: calc(403px / 1.2);
}

.strike-row-1 {
  width: 400px;
  height: 5px;
  background-color: aquamarine;
  top: 66px;
  left: 0;
}

.strike-row-2 {
  width: 400px;
  height: 5px;
  background-color: aquamarine;
  top: calc(66px * 3.3);
  left: 0;
}

.strike-row-3 {
  width: 400px;
  height: 5px;
  background-color: aquamarine;
  top: calc(66px * 5.5);
  left: 0;
}

.strike-diagonals-1 {
  width: 146%;
  height: 5px;
  background-color: aquamarine;
  top: 0;
  -webkit-transform: rotate(47deg) translateY(0) translateX(0);
  transform-origin: top left;
}

.strike-diagonals-2 {
  top: 0;
  right: 0;
  width: 146%;
  height: 5px;
  background-color: aquamarine;
  transform: rotate(-47deg);
  transform-origin: top right;
}

.container-game {
  position: relative;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-row-gap: 16px;
  grid-column-gap: 16px;
  width: 400px;
  margin-bottom: 20px;
}
</style>
