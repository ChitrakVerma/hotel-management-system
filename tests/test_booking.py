# tests/test_booking.py
# CI #4: Test Cases
# Description: Sample unit tests for the Booking module.

import unittest
from datetime import date, timedelta


# ---------------------------------------------------------------------------
# Minimal stub – mirrors the booking domain logic without a full framework.
# Replace with actual imports once the backend package is implemented.
# ---------------------------------------------------------------------------

class Booking:
    """Lightweight stub representing a hotel booking record."""

    def __init__(self, guest_id: int, room_id: int,
                 check_in: date, check_out: date):
        if check_out <= check_in:
            raise ValueError("check_out must be after check_in")
        self.guest_id = guest_id
        self.room_id = room_id
        self.check_in = check_in
        self.check_out = check_out
        self.status = "confirmed"

    @property
    def nights(self) -> int:
        return (self.check_out - self.check_in).days

    def cancel(self):
        if self.status == "checked_in":
            raise RuntimeError("Cannot cancel a booking that is already checked in")
        self.status = "cancelled"

    def check_in_guest(self):
        self.status = "checked_in"

    def check_out_guest(self):
        if self.status != "checked_in":
            raise RuntimeError("Guest must be checked in before checking out")
        self.status = "checked_out"


# ---------------------------------------------------------------------------
# Test cases
# ---------------------------------------------------------------------------

class TestBookingCreation(unittest.TestCase):

    def _make_booking(self, nights=2):
        today = date.today()
        return Booking(
            guest_id=1,
            room_id=101,
            check_in=today,
            check_out=today + timedelta(days=nights),
        )

    def test_valid_booking_is_confirmed(self):
        booking = self._make_booking()
        self.assertEqual(booking.status, "confirmed")

    def test_nights_calculated_correctly(self):
        booking = self._make_booking(nights=3)
        self.assertEqual(booking.nights, 3)

    def test_invalid_dates_raise_value_error(self):
        today = date.today()
        with self.assertRaises(ValueError):
            Booking(guest_id=1, room_id=101,
                    check_in=today, check_out=today)  # same day

    def test_checkout_before_checkin_raises_value_error(self):
        today = date.today()
        with self.assertRaises(ValueError):
            Booking(guest_id=1, room_id=101,
                    check_in=today, check_out=today - timedelta(days=1))


class TestBookingCancellation(unittest.TestCase):

    def _confirmed_booking(self):
        today = date.today()
        return Booking(1, 101, today, today + timedelta(days=2))

    def test_cancel_confirmed_booking(self):
        booking = self._confirmed_booking()
        booking.cancel()
        self.assertEqual(booking.status, "cancelled")

    def test_cannot_cancel_checked_in_booking(self):
        booking = self._confirmed_booking()
        booking.check_in_guest()
        with self.assertRaises(RuntimeError):
            booking.cancel()


class TestCheckInCheckOut(unittest.TestCase):

    def _confirmed_booking(self):
        today = date.today()
        return Booking(1, 101, today, today + timedelta(days=2))

    def test_check_in_changes_status(self):
        booking = self._confirmed_booking()
        booking.check_in_guest()
        self.assertEqual(booking.status, "checked_in")

    def test_check_out_after_check_in(self):
        booking = self._confirmed_booking()
        booking.check_in_guest()
        booking.check_out_guest()
        self.assertEqual(booking.status, "checked_out")

    def test_check_out_without_check_in_raises_error(self):
        booking = self._confirmed_booking()
        with self.assertRaises(RuntimeError):
            booking.check_out_guest()


if __name__ == "__main__":
    unittest.main()
