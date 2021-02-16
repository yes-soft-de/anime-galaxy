import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CategoryService } from '../../services/category.service';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { ListCategory } from '../../entity/list-category';
import { ToastrService } from 'ngx-toastr';
import { ImageSnippet } from '../../entity/image-snippet';
import { ListCategoryResponse } from '../../entity/list-category-response';
import { CategoryResponse } from '../../entity/category-response';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';

@Component({
  selector: 'app-edit-category',
  templateUrl: './edit-category.component.html',
  styleUrls: ['./edit-category.component.scss']
})
export class EditCategoryComponent implements OnInit {
  categoryId: number;
  isSubmitted = false;
  uploadForm: FormGroup;
  categoryData: ListCategory;
  uploadButtonValue = 'Upload';
  coverUploadButtonValue = 'Upload';
  imageName = 'Leave it if you don\'t want to change image';
  coverImageName = 'Leave it if you don\'t want to change cover image';
  fileSelected = false;
  coverFileSelected = false;
  imageUrl: string;
  coverImageUrl: string;
  imagePathReady = true;
  coverImagePathReady = true;
  submitButtonValue = 'Update Category';
  selectedFile: ImageSnippet;

  constructor(private categoryService: CategoryService,
              private tokenService: TokenService,
              private toaster: ToastrService,
              private formBuilder: FormBuilder,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {
    this.activatedRoute.paramMap.subscribe((param: ParamMap) => {
      this.categoryId = +param.get('id');
    });

    this.categoryService.getCategory(this.categoryId).subscribe(
      (categoryResponse: CategoryResponse) => {
        // console.log('CategoryResponse', categoryResponse);
        this.categoryData = categoryResponse.Data;
        this.updateFormValues();
      }, error => console.log(error)
    );

    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      name: ['', [Validators.minLength(2)]],
      description: [''],
      titleShow: ['', [Validators.required]],
      image: [''],
      coverImage: ['']
    });
  }

  // Fill Form Input
  updateFormValues() {
    this.uploadForm.patchValue({    // Insert Our category Data Into Form Fields
      name: this.categoryData.name,
      description: this.categoryData.description,
      titleShow: this.categoryData.titleShow,
      image: this.categoryData.image,
      coverImage: this.categoryData.coverImage,
    });
  }

  changeTitleStatus(event) {
    this.uploadForm.get('titleShow').setValue(event.target.value, {
      onlySelf: true
    });
  }

  // Select Image Information
  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  updateCoverName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.coverUploadButtonValue = 'Upload';
    this.coverImageName = file.name;
    this.coverFileSelected = true;
  }


  // Upload The Image And Get The Image URL
  processFile(imageInput: any) {
    this.imagePathReady = false;
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.categoryService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'Update Category';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  processCoverFile(imageInput: any) {
    this.coverFileSelected = false;
    this.coverImagePathReady = false;
    this.coverUploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.categoryService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.coverImageUrl = res;
          this.coverUploadButtonValue = 'Uploaded';
          this.coverImagePathReady = true;
          this.submitButtonValue = 'Update Category';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }

  // Submit Form
  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : All Fields Are Required');
      this.isSubmitted = false;
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObj = this.uploadForm.getRawValue();
      formObj.id = this.categoryId;
      formObj.updatedBy = this.tokenService.userName;
      // TODO make sure about the response of titleShow
      formObj.titleShow = formObj.titleShow == 0 ? false : true;
      if (this.imageUrl) {
        formObj.image = this.imageUrl;
      } else {
        formObj.image = this.categoryData.imageURL;
      }
      if (this.coverImageUrl) {
        formObj.coverImage = this.coverImageUrl;
      } else {
        formObj.coverImage = this.categoryData.coverImageURL;
      }
      this.categoryService.updateCategory(formObj).subscribe(
        data => {
          console.log('The post request was successfully done', data);
          this.toaster.success('Category Updated Successfully');
        },
        error => {
          this.toaster.error('Error : Please Try Again');
          console.log('Error fetching data', error);
        },
        () => {
          this.isSubmitted = false;
          this.router.navigate(['../../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }


}
