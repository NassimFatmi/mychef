<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;


Route::post('/user/create', [UserController::class,"create"]);
Route::post('/user/login',[UserController::class,"login"]);

Route::middleware('auth:sanctum')->get('/user/{id}',[ProfileController::class,'show']);