<?php

use App\Http\Controllers\TaskController;
use Illuminate\Support\Facades\Route;

Route::get('/tugas', [TaskController::class, 'index']);
Route::apiResource('tasks', TaskController::class);
