//
//  OrgPermission.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-10-08.
//

import Foundation

public enum OrgPermission: String, CaseIterable, Sendable {
    case viewBooking = "VIEW_BOOKING"
    case createBooking = "CREATE_BOOKING"
    case editBooking = "EDIT_BOOKING"
    case viewCostTrackingCodes = "VIEW_COST_TRACKING_CODES"
    case manageCostTrackingCodes = "MANAGE_COST_TRACKING_CODES"
    case getCrew = "GET_CREW"
    case editCrew = "EDIT_CREW"
    case editOrganization = "EDIT_ORGANIZATION"
    case editOrganizationContacts = "EDIT_ORGANIZATION_CONTACTS"
    case inviteOrganizationMembers = "INVITE_ORGANIZATION_MEMBERS"
    case createCreditApplication = "CREATE_CREDIT_APPLICATION"
    case editCreditApplication = "EDIT_CREDIT_APPLICATION"
    case finalizeCreditApplication = "FINALIZE_CREDIT_APPLICATION"
    case managePaymentCodes = "MANAGE_PAYMENT_CODES"
    case sharePaymentCodes = "SHARE_PAYMENT_CODES"
    case viewPaymentCodes = "VIEW_PAYMENT_CODES"
    case viewReports = "VIEW_REPORTS"
    case admFlagPagBookings = "ADM_FLAG_PAG_BOOKINGS"
    case viewSubcontractorBookings = "VIEW_SUBCONTRACTOR_BOOKINGS"
    case viewActiveBookings = "VIEW_ACTIVE_BOOKINGS"
    case viewPastBookings = "VIEW_PAST_BOOKINGS"
    case viewBookingsAttending = "VIEW_BOOKINGS_ATTENDING"
    case viewGuestBookings = "VIEW_GUEST_BOOKINGS"
    case editDutyOfCare = "EDIT_DUTY_OF_CARE"
    case editUserProfile = "EDIT_USER_PROFILE"
    case createMultiGuestBooking = "CREATE_MULTI_GUEST_BOOKING"
    
    static let adminPermissions: Set<OrgPermission> = Set(OrgPermission.allCases)
}

extension Set where Element == OrgPermission {
    public func satisfied(by permissions: Self) -> Bool {
        guard !isEmpty else { return true }
        
        return subtracting(permissions).isEmpty
    }
}
