<?php

namespace App\Http\Controllers;

use App\Models\Profile;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class UserController extends Controller
{
    public function create(Request $request){

        $user = User::where('email', $request->email)->first();
        $user =  new User();
        $user->name = $request->input('name');
        $user->email = $request->input('email');
        $user->password = Hash::make($request->input('password'));
        $user->save();

        if($request->input('profile')){
            $profile =  new Profile();
            $profile->user_id = $user->id;
            $profile->description = $request->input('description');
            $profile->rating = $request->input('rating');
            $profile->phone = $request->input('phone');
            $profile->location = $request->input('location');
            $profile->save();
            $user->profile_id = $profile->id;
        }
        $user->update();

        return $user->createToken($request->device_name)->plainTextToken;
    }

    public function login(Request $request){

        $request->validate([
            'email' => "required|email",
            "password" => "required",
            "device_name" => "required"
        ]);

        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        return $user->createToken($request->device_name)->plainTextToken;
    }
}
