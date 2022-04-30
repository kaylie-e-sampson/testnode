//
//  ConfigurationView.swift
//
//  Created by Kaylie Sampson 10/5/20
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Configurations
import Configuration
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?
        init(isShowing: Binding<Bool>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                isShowing = false
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing,
                           result: $result)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["kksamps2@gmail.com"])
        //vc.setMessageBody("<p> Name: \(nameFirstPre) </p>", isHTML: true)
        vc.setSubject("")
        vc.setMessageBody(getString(), isHTML: true)
        return vc
    }
    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {
    }
}
func getString() -> String{
    var output: String = "<p> Name: \(nameFirstPre) \(nameLastPre) </p>"
    output += "<p> License: \(licensePre) </p>"
    output += "<p> Birth Date: \(birthDatePre) </p>"
    output += "<p> Parent/Guardian Name: \(pGNameFirstPre) \(pGNameLastPre) </p>"
    output += "<p> Parent/Guardian Phone Number: \(pGNumberPre) </p>"
    output += "<p> Address: \(streetAddressPre) </p>"
    output += "<p> Address Line 2: \(address2Pre) </p>"
    output += "<p>\(cityPre), \(statePre) \(zipPre) </p>"
    output += "<p> Email: \(emailPre) </p>"
    output += "<p> Phone Number: \(numberPre) </p>"
    output += "<p> Language Assistance: \(langAssistancePre) </p>"
    output += "<p> Sex: \(sexPre) </p>"
    output += "<p> Ethnicity: \(isHispanicPre) </p>"
    output += "<p> \(travelInterstatePre) </p>"
    output += "<p> \(travelInternationalPre) </p>"
    output += "<p> \(medicaidPre) </p>"
    output += "<p> \(insurancePre) </p>"
    output += "<p> \(asapPre) </p>"
    output += "<p> \(symptomsPre) </p>"
    output += "<p> \(healthcarePre) </p>"
    output += "<p> \(sixtyPre) </p>"
    output += "<p> \(lungPre) </p>"
    output += "<p> \(heartPre) </p>"
    output += "<p> \(immunoPre) </p>"
    output += "<p> \(obesityPre) </p>"
    output += "<p> \(diabetesPre) </p>"
    output += "<p> \(kidneyPre) </p>"
    output += "<p> \(liverDisPre) </p>"
    output += "<p> \(dayCarePre) </p>"
    output += "<p> \(householdPre) </p>"
    output += "<p> \(employeePre) </p>"
    return output
}
public var nameFirstPre: String = "", nameLastPre: String = "", licensePre: String = "N/A", birthDatePre: Date = Date(), pGNameFirstPre: String = "N/A", pGNameLastPre: String = "N/A", pGNumberPre: String = "N/A", streetAddressPre: String = "", address2Pre: String = "N/A", cityPre: String = "", zipPre: String = "", emailPre: String = "N/A", numberPre: String = "", statePre: String = "", langAssistancePre: String = "N/A", sexPre: String = "", isHispanicPre: String = "", travelInternationalPre: String = "Has not travelled internationally", travelInterstatePre: String = "Has not travelled interstate", medicaidPre: String = "Is not interested in applying for Medicaid", insurancePre: String = "", asapPre: String = "Is not part of the ASAP", symptomsPre: String = "", healthcarePre: String = "Is not a healthcare worker", sixtyPre: String = "Is under 60 years old", lungPre: String = "Does not have chronic lung disease or moderate to severe asthma", heartPre: String = "Doesn't have serious heart conditions", immunoPre: String = "Is not immunocompromised", obesityPre: String = "Is not obese", diabetesPre: String = "Does not have diabetes", kidneyPre: String = "Does not have chronic kidney disease", liverDisPre: String = "Does not have liver disease", dayCarePre: String = "Is not involved with daycare", householdPre: String = "Doesn't have household members of vunerable populations", employeePre: String = "Can avoid prolonged close contact with peers and the general public"

public struct ConfigurationsView: View {
    let store: Store<ConfigurationsState, ConfigurationsState.Action>
    var viewStore: ViewStore<ConfigurationsState, ConfigurationsState.Action>
    public init(store: Store<ConfigurationsState, ConfigurationsState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store, removeDuplicates: ==)
    }
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    enum MenuItem: String, CaseIterable, Identifiable {
        var id : MenuItem {
            self
        }
        case firstCase = "Prescreening"
        case secondCase = "Check In"
        case thirdCase = "Check Out"
    }
    func getDestination(itemText: String) -> AnyView {
        let value = MenuItem(rawValue: itemText)
        switch value {
        case .some(.firstCase):
            return AnyView(prescreen)
        case.some(.secondCase):
            return AnyView(checkIn)
        case .none:
            return AnyView(Text("a"))
        case .some(.thirdCase):
            return AnyView(checkOut)
        }
    }
    public var body: some View{
        NavigationView {
            VStack {
                Divider()
                List(MenuItem.allCases) { itemText in
                    NavigationLink(destination: self.getDestination(itemText: itemText.rawValue)) {
                        HomeMenuRow(itemText: itemText.rawValue)
                            .font(.system(size: 30.0))
                    }
                }
                Image("IconImage")
                Spacer()
            }
            .padding([.top, .bottom], 8.0)
            .navigationBarTitle("Testing")
            .font(.system(size: 30.0))
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(false)
        }
        
    }
    @State var controller = ViewController()
    var prescreen: some View {
        ScrollView{
            VStack{
                contactInfo
                addressView
                ethnicityView1
                ethnicityView2
                insuranceView
                symptomsView1
                symptomsView2
                VStack {
                    if MFMailComposeViewController.canSendMail() {
                        Button(action: {
                            self.isShowingMailView.toggle()
                        }) {
                            Text("Submit").font(.system(size: 24.0))
                        }
                        .padding([.top, .bottom], 8.0)
                        .frame(width: 120.0, height: 60.0)
                        .overlay(Rectangle().stroke(Color("accent"), lineWidth: 7.0))
                        .shadow(radius: 2.0)
                    } else {
                        Text("Can't send emails from this device")
                            .background(Color("highlight"))
                    }
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(isShowing: self.$isShowingMailView, result: self.$result)
                }
                Spacer()
            }
            .background(Color("gridBackground"))
            .navigationBarTitle("Patient Information")
            .navigationViewStyle(StackNavigationViewStyle())
            .font(.system(size: 25.0))
        }
    }
    var checkIn: some View {
        ScrollView{
            VStack{
                contactInfo2
                addressView2
                insuranceView2
                symptomsCheckIn
                VStack {
                    if MFMailComposeViewController.canSendMail() {
                        Button(action: {
                            self.isShowingMailView.toggle()
                        }) {
                            Text("Submit").font(.system(size: 24.0))
                        }
                        .padding([.top, .bottom], 8.0)
                        .frame(width: 120.0, height: 60.0)
                        .overlay(Rectangle().stroke(Color("accent"), lineWidth: 7.0))
                        .shadow(radius: 2.0)
                    } else {
                        Text("Can't send emails from this device")
                            .background(Color("highlight"))
                    }
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(isShowing: self.$isShowingMailView, result: self.$result)
                }
                Spacer()
            }
            .background(Color("gridBackground"))
            .navigationBarTitle("Check In")
            .navigationViewStyle(StackNavigationViewStyle())
            .font(.system(size: 25.0))
        }
    }
    var checkOut: some View {
        ScrollView{
            VStack{
                checkOutInfo
                VStack {
                    if MFMailComposeViewController.canSendMail() {
                        Button(action: {
                            self.isShowingMailView.toggle()
                        }) {
                            Text("Submit").font(.system(size: 24.0))
                        }
                        .padding([.top, .bottom], 8.0)
                        .frame(width: 120.0, height: 60.0)
                        .overlay(Rectangle().stroke(Color("accent"), lineWidth: 7.0))
                        .shadow(radius: 2.0)
                    } else {
                        Text("Can't send emails from this device")
                            .background(Color("highlight"))
                    }
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(isShowing: self.$isShowingMailView, result: self.$result)
                }
                Spacer()
            }
            .navigationBarTitle("Check Out")
            .navigationViewStyle(StackNavigationViewStyle())
            .font(.system(size: 25.0))
        }
        .background(Color("gridBackground"))
    }
    @State var nameFirst: String = ""
    @State var nameLast: String = ""
    @State var license: String = ""
    @State var birthDate = Date()
    @State var age: Int = 0
    
    var contactInfo: some View {
        VStack{
            HStack{
                Text("Name").bold()
                Spacer()
            }
            HStack{
                TextField("First", text: $nameFirst, onEditingChanged: { focused in
                            nameFirstPre = nameFirst })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                TextField("Last", text: $nameLast, onEditingChanged: { focused in
                            nameLastPre = nameLast })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Driver License").bold()
                Spacer()
            }
            TextField("", text: $license, onEditingChanged: { focused in licensePre = license })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Button(action: {
                    self.viewStore.send(.setDrivers)
                }){
                    if(self.viewStore.hasDrivers == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Please select if you do not have a license.")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Text("Date of Birth").bold()
                Spacer()
            }
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Select a Date")
                    .font(.system(size: 20.0))
            }
            .onTapGesture{ birthDatePre = birthDate }
            HStack{
                Text("Age").bold()
                Spacer()
            }
            HStack{
                Text("\(Int(birthDate.timeIntervalSinceNow / 31540000) * -1) years old").font(.system(size: 20.0))
                Spacer()
            }
            if(((Int(birthDate.timeIntervalSinceNow / 31540000) * -1)) < 18){
                VStack{
                    Text("If you are under 18 years old, parent or guardian consent will be required to be tested. Please provide contact information for a parent or guardian below.")
                        .bold()
                        .font(.system(size: 17.0))
                        .background(Color("highlight"))
                        .lineLimit(nil)
                        .frame(maxHeight: .infinity)
                    parentInfo
                }
            }
            
        }
        .background(Color("gridBackground"))
    }
    @State var nameFirstCheckIn: String = ""
    @State var nameLastCheckIn: String = ""
    @State var birthDateCheckIn = Date()
    @State var ageCheckIn: Int = 0
    
    var contactInfo2: some View {
        VStack{
            HStack{
                Text("Name").bold()
                Spacer()
            }
            HStack{
                TextField("First", text: $nameFirstCheckIn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                TextField("Last", text: $nameLastCheckIn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Date of Birth").bold()
                Spacer()
            }
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Select a Date")
                    .font(.system(size: 20.0))
            }
            HStack{
                Text("Age").bold()
                Spacer()
            }
            HStack{
                Text("\(Int(birthDate.timeIntervalSinceNow / 31540000) * -1) years old").font(.system(size: 20.0))
                Spacer()
            }
            if(((Int(birthDate.timeIntervalSinceNow / 31540000) * -1)) < 18){
                VStack{
                    Text("If you are under 18 years old, parent or guardian consent will be required to be tested. Please provide contact information for a parent or guardian below.")
                        .bold()
                        .font(.system(size: 17.0))
                        .background(Color("highlight"))
                        .lineLimit(nil)
                    parentInfo
                }
            }
            
        }
    }
   
    @State var resultType : String = ""
    @State var name : String = ""
    var checkOutInfo: some View {
        VStack{
            HStack{
                Text("HIPAA Consent Form").bold()
                Spacer()
            }
            Text("")
            hippaView1
            hippaView2
            HStack{
                Text("I, ").font(.system(size: 17.0))
                TextField("Full Name", text: $name)
                    .font(.system(size: 17.0))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("do hereby").font(.system(size: 17.0))
            }
            Text("consent and acknowledge my agreement to the terms set forth in the HIPAA INFORMATION FORM and any subsequent changes in office policy. I understand that this consent shall remain in force from this time forward.").font(.system(size: 17.0))
            Text("")
            HStack{
                Text("How would you like your results?").bold()
                Spacer()
            }
            HStack{
                TextField("Email/Phone/Wait in Office", text: $resultType)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    }
    @State var pGNameFirst: String = ""
    @State var pGNameLast: String = ""
    @State var pGNumber: String = ""
    var parentInfo: some View {
        VStack{
            HStack{
                Text("Parent/Guardian Name").bold()
                Spacer()
            }
            HStack{
                TextField("First", text: $pGNameFirst, onEditingChanged: { focused in pGNameFirstPre = pGNameFirst })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                TextField("Last", text: $pGNameLast, onEditingChanged: { focused in pGNameLastPre = pGNameLast })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Parent/Guardian Phone Number").bold()
                Spacer()
            }
            TextField("000 000 0000", text: $pGNumber, onEditingChanged: { focused in pGNumberPre = pGNumber })
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    var hippaView2 : some View{
        VStack{
            Text("6.  Your confidential information will not be used for the purposes of marketing or advertising of products, goods or services.")
                .font(.system(size: 17.0))
            Text("7. We agree to provide patients with access to their records in accordance with state and federal laws.")
                .font(.system(size: 17.0))
            Text("8. We may change, add, delete or modify any of these provisions to better serve the needs of the both thepractice and the patient.")
                .font(.system(size: 17.0))
            Text("9. You have the right to request restrictions in the use of your protected health information and to request changein certain policies used within the office concerning your PHI. However, we are not obligated to alter internal policies to conform to your request.")
                .font(.system(size: 17.0))
        }
    }
    var hippaView1 : some View{
        VStack{
            Text("The Health Insurance Portability and Accountability Act (HIPAA) provides certain rights and protections to you as the patient. They have adopted the following policies:")
                .font(.system(size: 17.0))
            Text("1. Patient information will be kept confidential except as is necessary to provide services or to ensure that all administrative matters related to your care are handled appropriately. This specifically includes the sharing of information with other healthcare providers, laboratories, health insurance payers as is necessary and appropriate for your care. Patient files may be stored in open file racks and will not contain any coding which identifies a patient’s condition or information which is not already a matter of public record. The normal course of providing care means that such records may be left, at least temporarily, in administrative areas such as the front office, examination room, etc. Those records will not be available to persons other than office staff . You agree to the normal procedures utilized within the office for the handling of charts, patient records, PHI and other documents or information.")
                .font(.system(size: 17.0))
            Text("2. It is the policy of this office to remind patients of their appointments. We may do this by telephone, e-mail, U.S mail, or by any means convenient for the practice and/or as requested by you. We may send you other communications informing you of changes to office policy and new technology that you might find valuable or informative.")
                .font(.system(size: 17.0))
            Text("3. The practice utilizes a number of vendors in the conduct of business. These vendors may have access to PHI but must agree to abide by the confidentiality rules of HIPAA.")
                .font(.system(size: 17.0))
            Text("4. You understand and agree to inspections of the office and review of documents which may include PHI by government agencies or insurance payers in normal performance of their duties.")
                .font(.system(size: 17.0))
            Text("5. You agree to bring any concerns or complaints regarding privacy to the attention of the office manger or the doctor.")
                .font(.system(size: 17.0))
        }
    }
    var ethnicityView2 : some View{
        VStack{
            HStack{
                Text("Ethnicity").bold()
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setEthnicity)
                    if self.viewStore.isHispanic == true{
                        isHispanicPre = "Is Hispanic"
                    }
                }){
                    if(self.viewStore.isHispanic == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Hispanic")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setEthnicity2)
                    if self.viewStore.isNotHispanic == true{
                        isHispanicPre = "Is Not Hispanic"
                    }
                }){
                    if(self.viewStore.isNotHispanic == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Non-hispanic")
                    .font(.system(size: 17.0))
                Spacer()
            }
        }
    }
    var symptomsView2: some View{
        VStack{
            HStack{
                Button(action: {
                    self.viewStore.send(.setDiabetes)
                    if self.viewStore.isDiabetic == true{
                        diabetesPre = "Is Diabetic"
                    }
                }){
                    if(self.viewStore.isDiabetic == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Diabetes")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setKidneyDisease)
                    if self.viewStore.hasKidneyDisease == true{
                        kidneyPre = "Has chronic kidney disease"
                    }
                }){
                    if(self.viewStore.hasKidneyDisease == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Chronic kidney disease")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setLiverDisease)
                    if self.viewStore.hasLiverDisease == true{
                        liverDisPre = "Has liver disease"
                    }
                }){
                    if(self.viewStore.hasLiverDisease == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Liver disease")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setDayCare)
                    if self.viewStore.hasDayCare == true{
                        dayCarePre = "Involved with daycare"
                    }
                }){
                    if(self.viewStore.hasDayCare == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Daycare staff")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setHousehold)
                    if self.viewStore.hasHousehold == true{
                        householdPre = "Has household members of vunerable populations"
                    }
                }){
                    if(self.viewStore.hasHousehold == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Household members of vunerable populations")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setEmployee)
                    if self.viewStore.isEmployee == true{
                        employeePre = "Is an employee who cannot avoid prolonged close contact with peers or the general public"
                    }
                }){
                    if(self.viewStore.isEmployee == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("I am an employee who cannot avoid prolonged close contact with peers or the general public")
                    .font(.system(size: 17.0))
                Spacer()
            }
        }
    }
    
    var symptomsView1: some View {
        VStack {
            HStack{
                Text("Indicate if any of the following apply to you:").bold()
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setAsap)
                    if self.viewStore.hasAsap == true{
                        asapPre = "Is part of the Asymptomatic Spread Assessment Program"
                    }
                }){
                    if(self.viewStore.hasAsap == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Asymptomatic Spread Assessment Program (ASAP)")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setSymptoms)
                    if self.viewStore.hasSymptoms == true{
                        symptomsPre = "Has Covid-19 symptoms"
                    }
                }){
                    if(self.viewStore.hasSymptoms == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("COVID-19 Symptoms")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setNoSymptoms)
                    if self.viewStore.hasNoSymptoms == true{
                        symptomsPre = "Doesn't have Covid-19 symptoms"
                    }
                }){
                    if(self.viewStore.hasNoSymptoms == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("No symptoms")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setHealthWorker)
                    if self.viewStore.isHealthWorker == true{
                        healthcarePre = "Is a healthcare worker"
                    }
                }){
                    if(self.viewStore.isHealthWorker == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Healthcare worker")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.set60)
                    if self.viewStore.is60 == true{
                        sixtyPre = "Is 60 years old or more"
                    }
                }){
                    if(self.viewStore.is60 == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("60 years old or more")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setAsthma)
                    if self.viewStore.hasAsthma == true{
                        lungPre = "Has chronic lung diease or moderate to severe asthma"
                    }
                }){
                    if(self.viewStore.hasAsthma == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Chronic lung disease or moderate to severe asthma")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setHeartCond)
                    if self.viewStore.hasHeartCond == true{
                        heartPre = "Has serious heart conditions"
                    }
                }){
                    if(self.viewStore.hasHeartCond == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Serious heart conditions")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setImmuno)
                    if self.viewStore.isImmuno == true{
                        immunoPre = "Is immunocompromised"
                    }
                }){
                    if(self.viewStore.isImmuno == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Immunocompromised")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setObesity)
                    if self.viewStore.isObese == true{
                        obesityPre = "Is obese"
                    }
                }){
                    if(self.viewStore.isObese == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Obesity")
                    .font(.system(size: 17.0))
                Spacer()
            }
        }
    }
    @State var insuranceCarrier: String = ""
    var insuranceView: some View {
        VStack{
            HStack{
                Text("Have you traveled in the past 2 weeks?").bold()
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setTravelState)
                    if self.viewStore.hasTravelState == true{
                        travelInterstatePre = "Has travelled interstate"
                    }
                }){
                    if(self.viewStore.hasTravelState == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Yes, interstate")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setTravelInternational)
                    if self.viewStore.hasTravelInternational == true{
                        travelInternationalPre = "Has travelled internationally"
                    }
                }){
                    if(self.viewStore.hasTravelInternational == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Yes, internationally")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setNoTravel)
                }){
                    if(self.viewStore.hasNotTravel == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("No")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Text("Medicaid Coverage").bold()
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setMedicaid)
                    if self.viewStore.wantsMedicaid == true{
                        medicaidPre = "Is interested in applying for Medicaid"
                    }
                }){
                    if(self.viewStore.wantsMedicaid == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("If you are interested in applying for Medicaid coverage only for COVID-19 testing services, please check this box. You will receive an e-mail with a link to the simple Medicaid application for testing coverage that can be filled out and processed electronically in NH EASY. If you choose not to fill out and/or submit the application electronically, you may print out the application, sign it, and either e-mail, fax or mail it back to the Department of Health and Human Services. Further information on non-electronic submission is provided in NH EASY. If you have any questions about this Medicaid testing program, please call (603) 271-7373. Please be aware that this number is only for questions related to the Medicaid application for testing coverage; it is NOT for questions about your test schedule or for test results.")
                    .font(.system(size: 17.0))
                Spacer()
            }
            Text("If applicable, the lab running the test will bill the insurance company.").bold().font(.system(size: 17.0))
            HStack{
                Text("Insurance Carrier").bold()
                Spacer()
            }
            TextField("Please enter only the carrier name", text: $insuranceCarrier, onEditingChanged: { focused in insurancePre = insuranceCarrier})
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    @State var insuranceCarrierCheckIn: String = ""
    @State var carMake: String = ""
    @State var carModel: String = ""
    var insuranceView2: some View {
        VStack{
            HStack{
                Text("Insurance Carrier").bold()
                Spacer()
            }
            TextField("Please enter only the carrier name", text: $insuranceCarrierCheckIn)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Text("Car Make").bold()
                Spacer()
            }
            TextField("", text: $carMake)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Text("Car Model").bold()
                Spacer()
            }
            TextField("", text: $carModel)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    @State var symptomsDescription: String = ""
    var symptomsCheckIn: some View {
        VStack{
            HStack{
                Text("Please specific if you have any Covid-19 Symptoms").bold()
                Spacer()
            }
            TextField("Tempterature/Cough/etc.", text: $symptomsDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    @State var langAssistance: String = ""
    @State var sex: String = "Female"
    var ethnicityView1: some View {
        VStack{
            HStack{
                Text("Do you need language assistance services for your testing appointment?").bold()
                Spacer()
            }
            TextField("If so, please specify", text: $langAssistance, onEditingChanged: { focused in langAssistancePre = langAssistance })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Text("Sex").bold()
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setSexM)
                    if self.viewStore.isMale == true{
                        sex = "Male"
                    }
                    sexPre = sex
                }){
                    if(self.viewStore.isMale == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Male")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setSexF)
                    if self.viewStore.isFemale == true{
                        sex = "Female"
                    }
                    sexPre = sex
                }){
                    if(self.viewStore.isFemale == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Female")
                    .font(.system(size: 17.0))
                Spacer()
            }
        }

    }
    @State var streetAddressCheckIn: String = ""
    @State var address2CheckIn: String = ""
    @State var cityCheckIn: String = ""
    @State var zipCheckIn: String = ""
    @State var emailCheckIn: String = ""
    @State var numberCheckIn: String = ""
    @State var stateCheckIn: String = ""
    @State var confirmEmailCheckIn: String = ""
    
    var addressView2: some View {
        VStack{
            HStack{
                Text("Home Address").bold()
                Spacer()
            }
            TextField("Street Address", text: $streetAddressCheckIn)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Address Line 2", text: $address2CheckIn)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                TextField("City", text: $cityCheckIn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("State / Province", text: $stateCheckIn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            TextField("ZIP / Postal Code", text: $zipCheckIn)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Text("Email").bold()
                Spacer()
            }
            VStack{
                TextField("Enter Email", text: $emailCheckIn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Confirm Email", text: $confirmEmailCheckIn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setEmail)
                }){
                    if(self.viewStore.hasEmail == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Please select if you do not have a email address.")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Text("Phone Number").bold()
                Spacer()
            }
            TextField("000 000 0000", text: $numberCheckIn)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    @State var streetAddress: String = ""
    @State var address2: String = ""
    @State var city: String = ""
    @State var zip: String = ""
    @State var email: String = ""
    @State var number: String = ""
    @State var state: String = ""
    @State var confirmEmail: String = ""
    
    var addressView: some View {
        VStack{
            HStack{
                Text("Home Address").bold()
                Spacer()
            }
            TextField("Street Address", text: $streetAddress, onEditingChanged: { focused in streetAddressPre = streetAddress})
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Address Line 2", text: $address2, onEditingChanged: { focused in address2Pre = address2})
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                TextField("City", text: $city, onEditingChanged: { focused in cityPre = city})
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("State / Province", text: $state, onEditingChanged: { focused in statePre = state})
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            TextField("ZIP / Postal Code", text: $zip, onEditingChanged: { focused in zipPre = zip})
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Text("Email").bold()
                Spacer()
            }
            VStack{
                TextField("Enter Email", text: $email, onEditingChanged: { focused in emailPre = email})
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Confirm Email", text: $confirmEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Button(action: {
                    self.viewStore.send(.setEmail)
                }){
                    if(self.viewStore.hasEmail == false){
                        Image(systemName: "circle")
                    }
                    else{
                        Image(systemName: "circle.fill")
                    }
                }
                Text("Please select if you do not have a email address.")
                    .font(.system(size: 17.0))
                Spacer()
            }
            HStack{
                Text("Phone Number").bold()
                Spacer()
            }
            TextField("000 000 0000", text: $number, onEditingChanged: { focused in numberPre = number})
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    struct HomeMenuRow : View  {
        var itemText: String
        var body: some View {
            Text(itemText)
        }
    }
}
public struct ConfigurationsView_Previews: PreviewProvider {
    static let previewState = ConfigurationsState()
    public static var previews: some View {
        ConfigurationsView(
            store: Store(
                initialState: previewState,
                reducer: configurationsReducer,
                environment: ConfigurationsEnvironment()
            )
        )
    }
}
