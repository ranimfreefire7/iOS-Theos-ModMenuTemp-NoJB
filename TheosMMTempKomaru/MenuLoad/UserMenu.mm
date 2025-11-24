#import <Foundation/Foundation.h>
#import "imGui.h"
#import <mach-o/dyld.h>
#import <dlfcn.h>

// --- متغيرات القائمة (Menu Variables) ---
bool showMenu = true; // اجعليها true لتظهر القائمة عند التشغيل
bool isVerified = false;
char keyInput[64] = ""; 

// خيارات القائمة الوهمية
bool aimfov = false;
bool aimsilent = false;
bool espbox = false;
bool esplines = false;
bool ninjarun = false;
bool speedhack = false;

// --- دالة الحماية (Anti-Steal) ---
bool CheckIntegrity() {
    Dl_info info;
    if (dladdr((const void*)CheckIntegrity, &info)) {
        NSString *path = [NSString stringWithUTF8String:info.dli_fname];
        // يجب أن يكون الاسم Ranim
        if (![path containsString:@"Ranim"]) {
            return false; 
        }
    }
    return true;
}

// --- تصميم رنيم الوردي (Theme) ---
void SetupStyle() {
    ImGuiStyle& style = ImGui::GetStyle();
    style.WindowRounding = 12.0f;
    style.FrameRounding = 6.0f;
    
    ImVec4 pink = ImVec4(1.00f, 0.40f, 0.70f, 1.00f); 
    ImVec4 darkPink = ImVec4(0.80f, 0.20f, 0.50f, 0.90f); 
    ImVec4 blurBG = ImVec4(0.10f, 0.05f, 0.10f, 0.85f); 

    style.Colors[ImGuiCol_WindowBg] = blurBG;
    style.Colors[ImGuiCol_TitleBg] = darkPink;
    style.Colors[ImGuiCol_TitleBgActive] = pink;
    style.Colors[ImGuiCol_CheckMark] = pink;
    style.Colors[ImGuiCol_Text] = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
}

// --- رسم القائمة (Draw Function) ---
// ملاحظة: في هذا القالب، عادة يتم استدعاء هذه الدالة من الخارج
void DrawMenu() {
    // 1. فخ الحماية
    if (!CheckIntegrity()) {
        ImGui::Begin("SECURITY ALERT 🚫", nullptr, ImGuiWindowFlags_NoResize | ImGuiWindowFlags_AlwaysAutoResize);
        ImGui::TextColored(ImVec4(1, 0, 0, 1), "Wlhla sre9tih wa tir b zekek"); 
        ImGui::Text("File name must be: Ranim.dylib");
        ImGui::End();
        return;
    }

    SetupStyle(); 

    ImGui::Begin("Ranim Cheats 🌸", &showMenu);

    // 2. نظام المفتاح
    if (!isVerified) {
        ImGui::Text("Bghiti tkhdem bih chri key 🔑");
        ImGui::InputText("Key", keyInput, 64);
        if (ImGui::Button("Activate")) {
            if (strcmp(keyInput, "Ranim") == 0) {
                isVerified = true;
            }
        }
        ImGui::End();
        return;
    }

    // 3. القائمة الرئيسية
    ImGui::Text("Welcome Ranim ✨");
    ImGui::Separator();

    if (ImGui::CollapsingHeader("AIMBOT")) {
        ImGui::Checkbox("Aimfov 360", &aimfov);
        if (aimfov) ImGui::TextColored(ImVec4(1, 0, 1, 1), "  [Active 🔥]");
        ImGui::Checkbox("Aims Silent", &aimsilent);
    }

    if (ImGui::CollapsingHeader("ESP")) {
        ImGui::Checkbox("Esp Box", &espbox);
        ImGui::Checkbox("Esp Lines", &esplines);
    }
    
    if (ImGui::CollapsingHeader("MISC")) {
         ImGui::Checkbox("Ninja Run", &ninjarun);
         ImGui::Checkbox("Speed", &speedhack);
    }

    ImGui::Separator();
    ImGui::Text("Protected by Ranim 🛡️");
    ImGui::End();
}
