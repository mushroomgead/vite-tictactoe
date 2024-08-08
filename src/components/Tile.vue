<script setup lang="ts">
defineProps<{
    index: number;
    title: string;
    onTap: (index: number) => void;
}>()

</script>
<template>
    <div class="grid-item" @click="onTap(index)">
        <span>{{ title }}</span>
    </div>
</template>

<style scoped>
.grid-item {
    height: 133px;
    border-radius: 10px;
    background-color: #43115B;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 40px;
    color: #ffffff;
    font-weight: 900;
}
</style>
