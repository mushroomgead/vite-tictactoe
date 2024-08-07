<script setup lang="ts">
import { ref } from 'vue';

enum Player {
  X = "X",
  O = "O"
}

enum GameState { }

let currentTurn = ref<Player>(Player.X)
let selectedMatrixX = ref<[number, number] | any>([])
let selectedMatrixO = ref<[number, number] | any>([])

function onTap(x: number, y: number) {
  modifyList([x, y])
}

function modifyList(arr: [number, number]) {
  const turn = currentTurn.value
  const [indexX, indexO] = getCurrentIndex(arr)
  const isChecked = turn === Player.X && indexO > -1 || turn === Player.O && indexX > -1 || turn === Player.X && indexX > -1 || turn === Player.O && indexO > -1

  if (isChecked) {
    return
  }

  currentTurn.value = currentTurn.value === Player.X ? Player.O : Player.X

  if (turn === Player.X) {
    selectedMatrixX.value.push(arr)
  }


  if (turn === Player.O) {
    selectedMatrixO.value.push(arr)
  }
}

function getCurrentIndex(arr: [number, number]): [number, number] {
  const indexX = getIndex(selectedMatrixX, arr)
  const indexO = getIndex(selectedMatrixO, arr)
  return [indexX, indexO]
}

function getIndex(list: any, arr: any) {
  const index = list.value ? list.value.findIndex((item: any) => item[0] === arr[0] && item[1] === arr[1]) : -1
  return index
}

function getStr(arr: [number, number]) {
  const indexX = getIndex(selectedMatrixX, arr)
  const indexO = getIndex(selectedMatrixO, arr)

  if (indexX > -1) {
    return Player.X
  }

  if (indexO > -1) {
    return Player.O
  }
  return ""
}

function checkWinner() {
}

</script>

<template>
  <div class="container-game">
    <div class="grid-item" @click="onTap(0, 0)">
      <span>{{ getStr([0, 0]) }}</span>
      <span>0, 0</span>
    </div>
    <div class="grid-item" @click="onTap(0, 1)">
      <span>{{ getStr([0, 1]) }}</span>
      <span>0, 1</span>
    </div>
    <div class="grid-item" @click="onTap(0, 2)">
      <span>{{ getStr([0, 2]) }}</span>
      <span>0, 2</span>
    </div>
    <div class="grid-item" @click="onTap(1, 0)">
      <span>{{ getStr([1, 0]) }}</span>
      <span>1, 0</span>
    </div>
    <div class="grid-item" @click="onTap(1, 1)">
      <span>{{ getStr([1, 1]) }}</span>
      <span>1, 1</span>
    </div>
    <div class="grid-item" @click="onTap(1, 2)">
      <span>{{ getStr([1, 2]) }}</span>
      <span>1, 2</span>
    </div>
    <div class="grid-item" @click="onTap(2, 0)">
      <span>{{ getStr([2, 0]) }}</span>
      <span>2, 0</span>
    </div>
    <div class="grid-item" @click="onTap(2, 1)">
      <span>{{ getStr([2, 1]) }}</span>
      <span>2, 1</span>
    </div>
    <div class="grid-item" @click="onTap(2, 2)">
      <span>{{ getStr([2, 2]) }}</span>
      <span>2, 2</span>
    </div>
  </div>
</template>

<style scoped>
.container-game {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-row-gap: 2px;
  grid-column-gap: 2px;
  background-color: red;
  width: 400px;
  height: 400px;
}

.grid-item {
  height: 133px;
  background-color: pink;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 40px;
  color: #000000;
}
</style>
