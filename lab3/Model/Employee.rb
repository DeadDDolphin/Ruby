# frozen_string_literal: true
require_relative "./Validator/FacadeValidator"

# @author Dmitry Fedoruk
# Class describe instance of Employee
class Employee
  attr_accessor :fio, :birth_date,
   :phone_number, :adress,
   :mail, :pasport_serial,
   :speciality, :expirience,
   :last_place_of_job,
   :last_job, :last_zarplata

  # method for initialize object of Employee
  # @param data [Array<String>] length of array must be 11
  def initialize(data)
    set_all(data)
  end

  # method for convert class attributes to json format
  # @return [Hash<Attribute, Value>] size of hash equal 11
  def as_json
      {
        fio: @fio,
        birth_date: @birth_date,
        phone_number: @phone_number,
        adress: @adress,
        mail: @mail,
        pasport_serial: @pasport_serial,
        speciality: @speciality,
        expirience: @expirience,
        last_place_of_job: @last_place_of_job,
        last_job: @last_job,
        last_zarplata: @last_zarplata
      }
  end

  # class method for create Employee object by json data
  # @param json [JSON]
  def self.from_json(json)
    data = JSON.parse(json)
    new(data.values)
  end

  # @!group ValidSetters
  #   use class FacadeValidator to check and convert values to normal form

  # setter for attribute 'phone_number'
  # @param value [String] is some phone number in any format
  def phone_number=(value)
    @phone_number = FacadeValidator.check_phone(value)
  end

  # setter for attribute 'mail'
  # @param value [String] is some mail in any format
  def mail=(value)
    @mail = FacadeValidator.check_mail(value)
  end

  # setter for attribute 'fio'
  # @param value [String] is some fio in any format
  def fio=(value)
    @fio = FacadeValidator.check_fio(value)
  end

  # setter for attribute 'birth_date'
  # @param value [String] is some date in any format
  def birth_date=(value)
    @birth_date = FacadeValidator.check_date(value)
  end
  # @!endgroup

  # @!group JobSetters
  #   set value of attribute "No" if experience is 0
  #setter for attribute 'last_place_of_job'
  # @param place [String] some string with name of last place of job
  def last_place_of_job=(place)
    if @expirience > 0
      @last_place_of_job = place
    else
      @last_place_of_job = "No"
    end
  end

  #setter for attribute 'last_job'
  # @param job [String] some string with name of last job
  def last_job=(job)
    if @expirience > 0
      @last_job = job
    else
      @last_job = "No"
    end
  end

  #setter for attribute 'zarplata'
  # @param zarplata [String] some string with name of zarplata by last job
  def last_zarplata=(zarplata)
    if @expirience > 0
      @last_zarplata = zarplata
    else
      @last_zarplata = "No"
    end
  end
  # @!endgroup

  # set all attributes, used in initialize
  # @param data [Array<String>] length of array must be 11
  def set_all(data)
    self.fio = data[0]
    self.birth_date = data[1]
    self.phone_number = data[2]
    self.adress = data[3]
    self.mail = data[4]
    self.pasport_serial = data[5]
    self.speciality = data[6]
    self.expirience = data[7].to_i
    self.last_place_of_job = data[8]
    self.last_job = data[9]
    self.last_zarplata = data[10]
  end

  # method returned all attributes
  # @return [Array<String, Integer>]
  def get_all
    return @fio, @birth_date, @phone_number, @adress, @mail, @pasport_serial,
      @speciality, @expirience, @last_place_of_job, @last_job, @last_zarplata
  end

  # this method is overload to_s by Object class
  # @return [String] in format 'fio; place: place;
  #   phone: phone; birth_date: birth_date; mail: mail'
  def to_s
    return @fio +
    "; place: " + @last_place_of_job +
    "; phone: " + @phone_number +
    "; birth_date: " + @birth_date +
    "; mail: " + @mail
  end

  # this method is overload <=> by Object class
  # @param obj[Employee] is some instance of Employee
  # @return [Boolean] true if objects are equal
  #   false otherwise
  def <=>(obj)
    if (self.fio == obj.fio and
      self.birth_date == obj.birth_date and
      self.phone_number == obj.phone_number and
      self.adress == obj.adress and
      self.mail == obj.mail and
      self.pasport_serial == obj.pasport_serial and
      self.speciality == obj.speciality and
      self.expirience == obj.expirience and
      self.last_place_of_job == obj.last_place_of_job and
      self.last_job == obj.last_job and
      self.last_zarplata == obj.last_zarplata)
      true
    else
      false
    end
  end

  # @deprecated
  def change_job(place, job, money)
    if @expirience > 0
      @last_place_of_job = place
      @last_job = job
      @last_zarplata = money
    else
      puts "Че-то не то. Работаешь, не получая стажа работы?"
    end
  end
end
