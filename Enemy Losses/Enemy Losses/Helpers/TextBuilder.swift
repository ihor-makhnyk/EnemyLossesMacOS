//
//  TextBuilder.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

final class TextBuilder {
    enum TextVariants { case title,
                             tryzub,
                             
                             subtitle,
                             
                             cellTitle,
                             cellSubtitle,
                             cellDate,
                             
                             disclosureCellMonth,
                             disclosureCellYear,
                             
                             settingsTitle,
                             settingsDescription,
                             settingsNote,
                             
                             body,
                             
                             detailsDate,
                             detailsTitle,
                             detailsDescription,
                             detailsPersonnelValue,
                             detailsPersonnelText,
                             
                             aboutTitle,
                             aboutDescription
    }
    
    static func makeText(_ inputString: String, variant: TextVariants = .body) -> some View {
        VStack {
            let string = inputString.localized(lang: Localizer.locale.selectedLanguage)
            switch variant {
            case .body:
                Text(string).font(.custom("FixelDisplay-Regular", size: 10))
            case .subtitle:
                Text(string).font(.custom("FixelDisplay-Medium", size: 18)).multilineTextAlignment(.center).padding(.leading, 30)
                
            case .title:
                Text(string).font(.custom("FixelDisplay-Black", size: 28).width(.expanded))
            case .tryzub:
                Text(string).font(.custom("FixelDisplay-Light", size: 29))
                
            case .cellTitle:
                Text(string).font(.custom("FixelDisplay-Bold", size: 16))
            case .cellSubtitle:
                Text(string).font(.custom("FixelDisplay-Light", size: 12))
                
            case .cellDate:
                if let date = string.dateFromString() {
                    Text(date.format(.dayMonth)).font(.custom("FixelDisplay-Bold", size: 14))
                } else {
                    Text(string).font(.custom("FixelDisplay-Bold", size: 14))
                }
            case .disclosureCellMonth:
                if let date = string.dateFromString() {
                    Text(date.format(.dayMonth)).font(.custom("FixelDisplay-Bold", size: 22))
                } else {
                    Text(string).font(.custom("FixelDisplay-Bold", size: 22))
                }
            case .disclosureCellYear:
                if let date = string.dateFromString() {
                    Text(date.format(.yearShort)).font(.custom("FixelDisplay-Bold", size: 23)).opacity(0.4)
                } else {
                    Text(string).font(.custom("FixelDisplay-Black", size: 23.5)).opacity(0.4)
                }
                
            case .settingsTitle:
                Text(string).font(.custom("FixelDisplay-Bold", size: 18))
            case .settingsDescription:
                Text(string).font(.custom("FixelDisplay-Light", size: 14).width(.expanded))
            case .settingsNote:
                Text(string).font(.custom("FixelDisplay-Light", size: 12).width(.condensed))
                
            case .detailsDate:
                if let date = string.dateFromString() {
                    Text(date.format(.dayMonth)).font(.custom("FixelDisplay-Light", size: 16))
                } else {
                    Text(string).font(.custom("FixelDisplay-Light", size: 16))
                }
            case .detailsTitle:
                Text(string).font(.custom("FixelDisplay-Black", size: 24).width(.expanded))
            case .detailsDescription:
                Text(string).font(.custom("FixelDisplay-Light", size: 16))
            case .detailsPersonnelValue:
                Text(string).font(.custom("FixelDisplay-Black", size: 48).width(.expanded))
            case .detailsPersonnelText:
                Text(string).font(.custom("FixelDisplay-Regular", size: 24))
                
            case .aboutTitle:
                Text(string).font(.custom("FixelDisplay-Bold", size: 18))
            case .aboutDescription:
                HStack {
                    Text(string).font(.custom("FixelDisplay-Light", size: 14).width(.expanded)).multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
            }
        }.foregroundColor(.white)
    }
}



