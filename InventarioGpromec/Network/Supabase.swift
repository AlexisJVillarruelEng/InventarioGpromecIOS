//
//  Supabase.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 15/09/25.
//

import Foundation

import Supabase

final class SupabasemManager {
    static let shared = SupabasemManager()
    let client : SupabaseClient
    
    private init() {
        
        client = SupabaseClient(
            supabaseURL: URL(string: "https://olocxlmztfaguqdxfuvy.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9sb2N4bG16dGZhZ3VxZHhmdXZ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NzQ1NjcsImV4cCI6MjA3MzU1MDU2N30.HgikmtpFNj4LD1wl6s97Sp-dYxtUmVUCqA4Iqb0-G8Y"
        )
    }
}
