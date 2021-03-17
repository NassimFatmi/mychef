<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function show($id){
        $u = User::where('id', $id)->first();
        return $u?->profile;
    }
}
